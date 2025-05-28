import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.send("Welcome to the Dinosaur API!");
});

app.listen(8000, "0.0.0.0");
console.log(`Server is running on http://0.0.0.0:8000`);
