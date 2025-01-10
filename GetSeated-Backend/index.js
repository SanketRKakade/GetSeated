import dotenv from "dotenv";
import express from "express";

const app = express();
dotenv.config();
const port = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("API is running...");
});



app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});