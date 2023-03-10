const { Configuration, OpenAIApi } = require("openai");

const configuration = new Configuration({
//   apiKey: process.env.OPENAI_API_KEY,
    apiKey: "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",
});
const openai = new OpenAIApi(configuration);

const askButton = document.getElementById("ask-button");
askButton.addEventListener("click", async () => {
  const question = window.prompt("Ask a question about the page:");
  const model = "gpt-3.5-turbo";
  const chatParams = {
    model: model,
    messages: [{role: "user", content: question}],
  };
  try {
    const completion = await openai.createChatCompletion(chatParams);
    const answer = completion.data.choices[0].message;
    window.alert(answer);
  } catch (error) {
    console.log(error);
  }
});
