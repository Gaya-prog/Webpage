const stripe = Stripe("pk_test_51QkbVR07FUuvaDAkEVWEHpmsvZgCBISWPaEM6b1bPNvOBZlSmdhXWteoqBYmK11nHNMbPTaJoZhOK4fxySA3hgam000M7WVe2Z"); // Your Stripe Publishable Key
const elements = stripe.elements();

// Create a card element
const card = elements.create("card");
card.mount("#card-element");

const form = document.getElementById("payment-form");

form.addEventListener("submit", async (event) => {
  event.preventDefault();

  const { paymentMethod, error } = await stripe.createPaymentMethod({
    type: "card",
    card: card,
  });

  if (error) {
    document.getElementById("card-errors").textContent = error.message;
  } else {
    console.log("PaymentMethod ID:", paymentMethod.id);

    // Call your backend to create the PaymentIntent and get the clientSecret
    const response = await fetch("http://localhost:3000/create-payment-intent", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ amount: amountInput.value * 100, currency: "usd" }), // Convert dollars to cents // Sending amount and currency
    });

    const { clientSecret } = await response.json(); // Get clientSecret from the backend response

    // Confirm the payment with the clientSecret
    const { error: confirmError, paymentIntent } = await stripe.confirmCardPayment(clientSecret, {
      payment_method: paymentMethod.id,
    });

    if (confirmError) {
      document.getElementById("card-errors").textContent = confirmError.message;
    } else {
      alert("Payment successful!");
      console.log("PaymentIntent:", paymentIntent);
    }
  }
});
