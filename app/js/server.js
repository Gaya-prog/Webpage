const express = require("express");
const Stripe = require("stripe");
const bodyParser = require("body-parser");

require("dotenv").config(); // Load environment variables

const stripe = Stripe(process.env.STRIPE_SECRET_KEY); // Use the key from .env


app.use(bodyParser.json());

const cors = require("cors");
app.use(cors());

app.post("/create-payment-intent", async (req, res) => {
  const { amount, currency } = req.body;

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount, // Amount in cents
      currency: currency,
    });

    res.send({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

app.listen(3000, () => console.log("Server running on port 3000"));
