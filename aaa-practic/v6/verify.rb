#!/usr/bin/env ruby

# Comprehensive verification script for Ruby Todo CLI v6
# This script verifies all components are working correctly

require 'json'

class VerificationRunner
  def initialize
    @results = {}
    @errors = []
  end
  
  def run_all_verifications
    puts "🚀 Ruby Todo CLI v6 - Comprehensive Verification"
    puts "=" * 60
    
    verify_ruby_environment
    verify_file_structure
    verify_syntax_checks
    verify_unit_tests
    verify_integration_tests
    verify_demo_functionality
    verify_docker_setup
    
    print_summary
  end
  
  private
  
  def verify_ruby_environment
    puts "\n📋 1. Ruby Environment Verification"
    puts "-" * 40
    
    # Check Ruby version
    ruby_version = RUBY_VERSION
    puts "✅ Ruby Version: #{ruby_version}"
    @results[:ruby_version] = ruby_version
    
    # Check if bundler is available
    begin
      require 'bundler'
      puts "✅ Bundler: Available"
      @results[:bundler] = true
    rescue LoadError
      puts "❌ Bundler: Not available"
      @results[:bundler] = false
      @errors << "Bundler not available"
    end
    
    # Check gems
    begin
      require 'minitest'
      puts "✅ MiniTest: Available"
      @results[:minitest] = true
    rescue LoadError
      puts "❌ MiniTest: Not available"
      @results[:minitest] = false
      @errors << "MiniTest not available"
    end
  end
  
  def verify_file_structure
    puts "\n📁 2. File Structure Verification"
    puts "-" * 40
    
    required_files = [
      'main.rb',
      'Gemfile',
      'Gemfile.lock',
      'Dockerfile',
      'docker-compose.yml',
      'docker.sh',
      'entities/todo.rb',
      'interfaces/todo_repository.rb',
      'infrastructure/mem_db.rb',
      'infrastructure/cli.rb',
      'use_cases/create_todo.rb',
      'use_cases/list_todos.rb',
      'use_cases/complete_todo.rb',
      'use_cases/delete_todo.rb',
      'use_cases/count_todos.rb',
      'tests/test_use_cases.rb',
      'tests/test_integration.rb',
      'tests/mock_todo_repo.rb'
    ]
    
    missing_files = []
    
    required_files.each do |file|
      if File.exist?(file)
        puts "✅ #{file}"
      else
        puts "❌ #{file} - MISSING"
        missing_files << file
      end
    end
    
    @results[:file_structure] = missing_files.empty?
    @errors.concat(missing_files.map { |f| "Missing file: #{f}" }) unless missing_files.empty?
  end
  
  def verify_syntax_checks
    puts "\n🔍 3. Syntax Verification"
    puts "-" * 40
    
    ruby_files = Dir.glob("**/*.rb")
    syntax_errors = []
    
    ruby_files.each do |file|
      result = system("ruby -c #{file} > /dev/null 2>&1")
      if result
        puts "✅ #{file}"
      else
        puts "❌ #{file} - SYNTAX ERROR"
        syntax_errors << file
      end
    end
    
    @results[:syntax_check] = syntax_errors.empty?
    @errors.concat(syntax_errors.map { |f| "Syntax error in: #{f}" }) unless syntax_errors.empty?
  end
  
  def verify_unit_tests
    puts "\n🧪 4. Unit Tests Verification"
    puts "-" * 40
    
    test_output = `ruby tests/test_use_cases.rb 2>&1`
    test_success = $?.success?
    
    if test_success
      # Parse test results
      if test_output =~ /(\d+) runs, (\d+) assertions, (\d+) failures, (\d+) errors/
        runs, assertions, failures, errors = $1.to_i, $2.to_i, $3.to_i, $4.to_i
        puts "✅ Unit Tests: #{runs} runs, #{assertions} assertions"
        puts "✅ Failures: #{failures}, Errors: #{errors}"
        @results[:unit_tests] = { runs: runs, assertions: assertions, failures: failures, errors: errors }
      else
        puts "✅ Unit Tests: Passed (couldn't parse details)"
        @results[:unit_tests] = true
      end
    else
      puts "❌ Unit Tests: FAILED"
      @results[:unit_tests] = false
      @errors << "Unit tests failed"
    end
  end
  
  def verify_integration_tests
    puts "\n🔗 5. Integration Tests Verification"
    puts "-" * 40
    
    test_output = `ruby tests/test_integration.rb 2>&1`
    test_success = $?.success?
    
    if test_success
      if test_output =~ /(\d+) runs, (\d+) assertions, (\d+) failures, (\d+) errors/
        runs, assertions, failures, errors = $1.to_i, $2.to_i, $3.to_i, $4.to_i
        puts "✅ Integration Tests: #{runs} runs, #{assertions} assertions"
        puts "✅ Failures: #{failures}, Errors: #{errors}"
        @results[:integration_tests] = { runs: runs, assertions: assertions, failures: failures, errors: errors }
      else
        puts "✅ Integration Tests: Passed"
        @results[:integration_tests] = true
      end
    else
      puts "❌ Integration Tests: FAILED"
      @results[:integration_tests] = false
      @errors << "Integration tests failed"
    end
  end
  
  def verify_demo_functionality
    puts "\n🎬 6. Demo Functionality Verification"
    puts "-" * 40
    
    demo_output = `ruby demo.rb 2>&1`
    demo_success = $?.success?
    
    if demo_success && demo_output.include?("Demo completed successfully!")
      puts "✅ Demo Script: Working correctly"
      @results[:demo] = true
    else
      puts "❌ Demo Script: FAILED"
      @results[:demo] = false
      @errors << "Demo script failed"
    end
  end
  
  def verify_docker_setup
    puts "\n🐳 7. Docker Setup Verification"
    puts "-" * 40
    
    # Check Docker files exist
    docker_files = ['Dockerfile', 'docker-compose.yml', 'docker.sh', '.dockerignore']
    docker_files_exist = docker_files.all? { |f| File.exist?(f) }
    
    if docker_files_exist
      puts "✅ Docker Files: All present"
    else
      puts "❌ Docker Files: Some missing"
      @errors << "Missing Docker files"
    end
    
    # Check if docker.sh is executable
    if File.executable?('docker.sh')
      puts "✅ docker.sh: Executable"
    else
      puts "❌ docker.sh: Not executable"
      @errors << "docker.sh not executable"
    end
    
    @results[:docker_setup] = docker_files_exist && File.executable?('docker.sh')
  end
  
  def print_summary
    puts "\n📊 VERIFICATION SUMMARY"
    puts "=" * 60
    
    total_checks = @results.size
    passed_checks = @results.values.count { |v| v == true || (v.is_a?(Hash) && v[:failures] == 0 && v[:errors] == 0) }
    
    puts "Total Checks: #{total_checks}"
    puts "Passed: #{passed_checks}"
    puts "Failed: #{total_checks - passed_checks}"
    
    if @errors.empty?
      puts "\n🎉 ALL VERIFICATIONS PASSED!"
      puts "Ruby Todo CLI v6 is ready for use!"
    else
      puts "\n❌ VERIFICATION ISSUES FOUND:"
      @errors.each { |error| puts "  - #{error}" }
    end
    
    # Save results to file
    File.write('verification_results.json', JSON.pretty_generate(@results))
    puts "\nDetailed results saved to: verification_results.json"
  end
end

# Run verification if script is executed directly
if __FILE__ == $0
  verifier = VerificationRunner.new
  verifier.run_all_verifications
end
