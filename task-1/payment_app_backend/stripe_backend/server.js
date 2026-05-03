const express = require("express");
const stripe = require("stripe")("sk_test_51TS5cFGRKfP1slck4Kr13VETF27Fpd45rgSSXTsDgLopDJSIs9wtBmZNpPDiuGRS7G3i1WT0T1kGJ3u5Jpns8Vs500aBBoTxJm"); // your secret key
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.post("/create-payment-intent", async (req, res) => {
  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: req.body.amount,
      currency: "usd",
    });

    res.send({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (e) {
    res.status(500).send({ error: e.message });
  }
});

app.listen(3000, () => console.log("Server running on port 3000"));