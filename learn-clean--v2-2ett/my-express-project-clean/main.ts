import express from "express";
import swaggerJsdoc from "npm:swagger-jsdoc";
import swaggerUi from "npm:swagger-ui-express";
import data from "./assets/data.json" with { type: "json" };

const app = express();
const port = 8000;

// Swagger configuration
const swaggerOptions = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Dinosaur API',
      version: '1.0.0',
      description: 'A simple API for dinosaur data'
    },
    servers: [
      {
        url: `http://localhost:${port}`,
        description: 'Development server (localhost)'
      },
      {
        url: `http://0.0.0.0:${port}`,
        description: 'Development server (all interfaces)'
      },
      {
        url: `/`,
        description: 'reference to the root endpoint'
      }
    ],
  },
  apis: ['./main.ts'], // Path to the API files
};

const swaggerSpec = swaggerJsdoc(swaggerOptions);

/**
 * @swagger
 * /:
 *   get:
 *     summary: Welcome message
 *     description: Returns a welcome message for the Dinosaur API
 *     responses:
 *       200:
 *         description: Welcome message
 *         content:
 *           text/plain:
 *             schema:
 *               type: string
 *               example: "Welcome to the Dinosaur API!"
 */
app.get("/", (_req, res) => {
  res.send("Welcome to the Dinosaur API!");
});

/**
 * @swagger
 * /api:
 *   get:
 *     summary: Get all dinosaurs
 *     description: Returns the complete list of dinosaurs
 *     responses:
 *       200:
 *         description: List of all dinosaurs
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   name:
 *                     type: string
 *                   description:
 *                     type: string
 */
app.get("/api", (_req, res) => {
  res.send(data);
});

/**
 * @swagger
 * /api/{dinosaur}:
 *   get:
 *     summary: Get specific dinosaur
 *     description: Returns information about a specific dinosaur by name
 *     parameters:
 *       - name: dinosaur
 *         in: path
 *         required: true
 *         description: Name of the dinosaur to retrieve
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Dinosaur information
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 name:
 *                   type: string
 *                 description:
 *                   type: string
 *       404:
 *         description: Dinosaur not found
 *         content:
 *           text/plain:
 *             schema:
 *               type: string
 *               example: "No dinosaurs found."
 */
app.get("/api/:dinosaur", (req, res) => {
  if (req?.params?.dinosaur) {
    const found = data.find(
      (item) => item.name.toLowerCase() === req.params.dinosaur.toLowerCase()
    );
    if (found) {
      res.send(found);
    } else {
      res.send("No dinosaurs found.");
    }
  }
});

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.listen(port, "0.0.0.0");
console.log(`Server is running on http://0.0.0.0:${port}`);
console.log(`Swagger UI available at http://localhost:${port}/api-docs`);
console.log(`API accessible from network at http://0.0.0.0:${port}`);



// app.listen(port, () => {
//     console.log(`Server listening on port ${port}`);
//     console.log(`Swagger UI (potentially) at http://localhost:${port}/api-docs`);
// });