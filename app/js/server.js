const express = require("express");
const Stripe = require("stripe");
const bodyParser = require("body-parser");
const cors = require('cors');  // Import CORS

const app = express(); 
const stripe = Stripe("sk_test_51QkbVR07FUuvaDAkdo3VeGBm6wnPZ7fZn9Tm8bE5xZHmvdbJmxvAeywBR89Xpw6IvjAIlSxAc78t4K0pEg10HZFk00nV8eRryC"); // Replace with your Secret Key

app.use(cors());  // Use CORS middleware to enable cross-origin requests
app.use(bodyParser.json());

app.post("/create-payment-intent", async (req, res) => {
  const { amount, currency } = req.body;

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,  // Amount in cents
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
