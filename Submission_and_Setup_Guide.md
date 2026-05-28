# TASK_T11 — AI Chatbot Prompt Setup Submission (Grade A)

## 1. Live Chatbot Link
**Live App:** [https://adishilaai.netlify.app/](https://adishilaai.netlify.app/)

## 2. Short Setup Guide (Secure Serverless Edge Architecture)
The required chatbot was built using a **Secure Serverless Edge** architecture to completely protect the API keys while retaining a zero-maintenance "Serverless" deployment (no heavy backend servers required).

- **Frontend Environment:** Pure HTML/CSS with Vanilla JavaScript. Styled to match the premium "Primordial Stone" branding.
- **LLM Engine:** Google Gemini API (`gemini-2.5-flash`), accessed securely via Netlify Edge Functions.
- **Security implementation:** 
  1. The API key is securely injected into Netlify Environment Variables.
  2. The frontend points its calls to `/.netlify/functions/chat`.
  3. The `chat.js` Netlify function acts as a proxy, appending the API key silently and talking to Google's servers securely.
- **Prompt Engineering System:** The system instructions and Knowledge Base constraints are injected dynamically from the frontend to control context.
- **Rate Limit Protection:** Features an encoded UI cooldown (1.5s) to guarantee high stability on free API tiers.

**How to Edit/Deploy:**
1. Log into your Netlify dashboard.
2. Go to **Site Configuration -> Environment Variables**.
3. Add `GEMINI_API_KEY` = `YOUR_KEY`.
4. Deploy the `task_t11` folder. No changes to code required.

## 3. Trained Responses (10+ Scenarios Configured)
The chatbot has been highly prompted to handle the following **11 specific customer-service flows** for the "AdiShila" use-case:
1. **Greetings / Introduction:** Polite, spiritual welcome.
2. **Scientific/Spiritual Definition:** Defining Shungite properties.
3. **Product Catalog Listing:** Listing all available stones/pyramids/malas.
4. **Exact Pricing Lookups:** Prices for the Kavach, Lingam, Pyramid, etc.
5. **Wholesale / MOQ queries:** Minimum 25 pieces mix-and-match.
6. **Contextual Recommendations (Luck/Focus):** Vastu Dosh Pyramid for homes or college dorms.
7. **Personal Protection Recommendations:** Kavach Shield or Mala.
8. **International Shipping:** Worldwide shipping details.
9. **Purchase/Lead Process:** WhatsApp proforma pipeline via Akash.
10. **Refund / Return Policy:** Transit damage policies.
11. **Cleansing / Maintenance:** Moonlight & water guidelines.

---

## 4. Proofs Requirements

### Workflow / Prompt Screenshots
Below are the 5 screenshots demonstrating the custom UI, crafted responses, and contextual understanding.

- ![Proof 1](./proofs/screenshot_1.jpg)
- ![Proof 2](./proofs/screenshot_2.jpg)
- ![Proof 3](./proofs/screenshot_3.jpg)
- ![Proof 4](./proofs/screenshot_4.jpg)
- ![Proof 5](./proofs/screenshot_5.jpg)

### Sample Conversation Recording
*(The `.mp4` screen recording file is attached alongside this document in the final submission folder.)*