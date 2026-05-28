exports.handler = async function(event, context) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: "Method Not Allowed" };
  }

  // Retrieve key securely from Netlify Environment Variables
  const API_KEY = process.env.GEMINI_API_KEY;
  if (!API_KEY) {
    return { statusCode: 500, body: JSON.stringify({ error: "Missing API Key Configuration" }) };
  }

  try {
    const payload = JSON.parse(event.body);

    // Call Gemini securely from the backend edge network
    const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${API_KEY}`;
    
    // Using native Undici fetch in Node 18+
    const response = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });

    const data = await response.json();
    return {
      statusCode: response.status,
      body: JSON.stringify(data)
    };
  } catch (err) {
    return { 
      statusCode: 500, 
      body: JSON.stringify({ error: "Edge Function Error", details: err.message }) 
    };
  }
};
