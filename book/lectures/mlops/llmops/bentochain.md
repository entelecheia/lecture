# Deploy a Voice-Based Chatbot with BentoML, LangChain, and Gradio

## Introduction

BentoML is a powerful framework that allows users to package machine learning models as distributed microservices with simple Python code. It provides a unique distribution format known as a 'bento', which packages all ML-related elements, including source code, dependencies, API definitions, model weights, and Docker image, into one place. This makes it easy to deploy models to the cloud.

In this lecture, we'll discuss how to prototype an app, build a 'bento' locally, and push it to BentoCloud for deployment. We'll use transformers along with a few other libraries that process audio data and the popular LangChain package to easily integrate with Large Language Models (LLMs).

## Saving Models as BentoML Artifacts

This project assumes no training. We will simply download the models’ weights from HuggingFace’s hub and save them as BentoML Models. Saving the models as BentoML artifacts helps incorporate them in the bento archive so that they don’t constitute an external dependency.

## App’s Architecture

The user sends an audio message to the API server over an HTTP POST request. The API server redirects the audio message to the speech2text runner that transcribes it into text and sends it back. The API server takes the transcribed text message as input, passes it through a LangChain agent, generates a response, and sends it to the text2speech runner. The text2speech runner generates an audio clip from the input text and returns it to the API server which in turn sends it back to the user.

## BentoML Service

In this section, we create a service that defines the API routes that can be accessed when the bento is deployed. We first start by initializing the two previous runners we defined. Once the service is created, we will define two API routes: generate_text and generate_speech.

## The ChatWrapper Utility Class

In this section, we will mount a FastAPI app as an HTTP endpoint on the “/chatbot” path. This app will serve a Gradio chatbot interface that will interact with the two previously defined API routes: generate_text and generate_speech.

## Gradio UI

The Gradio UI is used to display a chatbot output showing both user-submitted messages and responses. It also includes a widget that plays the user’s recorded audio clip.

## Serve the App Locally

To serve the app locally, we use the command `bentoml serve service:svc --reload --ssl-certfile ssl/cert.pem --ssl-keyfile ssl/key.pem`. This starts a SwaggerUI from which you can try the two endpoints. This also serves the Gradio app on the “/chatbot” path.

## Deploy to BentoCloud

Before deploying to BentoCloud, we first need to build the bento. Then, we need to push it using the command `bentoml push voicegpt:jnalivxin2qcehqa`. This will upload our bento and the underlying models simultaneously to the cloud. Now, you log in to BentoCloud, head over to the deployment tab, and hit create. You pick a deployment name, enable public access and select the appropriate bento

tag version. Now, you define the API server configuration and set a configuration for each runner. When everything is set, hit the submit button and wait for deployment. When the bento is marked as running, you’ll see a public URL that serves the chatbot.

## Conclusion

This project was an opportunity to take part in the ongoing hype around Large Language Models (LLMs) and build an app from scratch that not only calls LangChain but combines it with other models as well. There’s of course room for improvement in the different steps of the workflow. This post was a good starter for you to start building more advanced bots.

**Source:** [Deploy a Voice-Based Chatbot with BentoML, LangChain, and Gradio](https://towardsdatascience.com/deploy-a-voice-based-chatbot-with-bentoml-langchain-and-gradio-7f25af3e45df) by Ahmed Besbes on Towards Data Science.
