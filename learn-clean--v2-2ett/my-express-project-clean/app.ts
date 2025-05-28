// app.ts
import { Hono } from "npm:hono"; // Using npm specifier for Hono
import { OpenAPIHono, createRoute } from "npm:@hono/zod-openapi";
import { swaggerUI } from "npm:@hono/swagger-ui";
import { z } from "npm:zod"; // Zod for schema validation and type generation

// const app = new Hono(); // Regular Hono app
const app = new OpenAPIHono(); // OpenAPIHono for spec generation

// Define a schema for request/response
const UserSchema = z
  .object({
    id: z.string().openapi({ example: "123" }),
    name: z.string().openapi({ example: "John Doe" }),
    age: z.number().openapi({ example: 42 }),
  })
  .openapi("User");

const ErrorSchema = z
  .object({
    code: z.number().openapi({ example: 400 }),
    message: z.string().openapi({ example: "Bad Request" }),
  })
  .openapi("Error");

// Define a route with OpenAPI metadata
const getUserRoute = createRoute({
  method: "get",
  path: "/users/{id}",
  request: {
    params: z.object({
      id: z.string().openapi({ description: "User ID" }),
    }),
  },
  responses: {
    200: {
      content: {
        "application/json": {
          schema: UserSchema,
        },
      },
      description: "Retrieve the user",
    },
    404: {
      content: {
        "application/json": {
          schema: ErrorSchema,
        },
      },
      description: "User not found",
    },
  },
  tags: ["Users"], // Tag for grouping in Swagger UI
});

// Implement the route handler
app.openapi(getUserRoute, (c) => {
  const { id } = c.req.valid("param");
  // In a real app, you'd fetch the user from a database
  if (id === "123") {
    return c.json({
      id,
      name: "John Doe",
      age: 42,
    });
  }
  return c.json({ code: 404, message: "User not found" }, 404);
});

// --- Add more routes similarly ---

// Serve Swagger UI
app.get(
  "/ui",
  swaggerUI({
    url: "/doc", // The endpoint for the OpenAPI spec
  })
);

// OpenAPI JSON spec endpoint
app.doc("/doc", {
  openapi: "3.1.0",
  info: {
    version: "1.0.0",
    title: "My Deno API with Hono",
    description: "An API built with Hono and documented with OpenAPI",
  },
  // You can add servers, securitySchemes, etc. here
});

Deno.serve(app.fetch);
console.log("Server running on http://localhost:8000");
console.log("Swagger UI available at http://localhost:8000/ui");
