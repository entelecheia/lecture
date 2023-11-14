# Retrieval Augmented Generation (RAG) based LLM Applications

```{image} figs/rag-architecture.png
:width: 100%
:align: center
```

- LLMs are sophisticated but not without flaws.
- Base LLMs struggle with up-to-date knowledge retrieval, contextual depth, environmental sustainability, and biases.
- RAG-based LLM applications aim to enhance LLM performance by integrating them with external knowledge sources.

## I. Introduction to Large Language Models (LLMs)

Large Language Models, or LLMs, are the pinnacle of natural language processing technologies, driving the frontier of machine understanding and generation of human language. These models are trained on vast datasets, enabling them to predict, generate, and contextualize text with impressive accuracy. However, despite their capabilities, base LLMs exhibit several limitations.

### Limitations of base LLMs

- **Lack of external knowledge**: Base LLMs are often confined to the information present in their training data, limiting their ability to provide updated or domain-specific information.
- **Contextual understanding**: While LLMs can grasp context over a few paragraphs, their understanding dwindles with longer texts, leading to coherence issues.
- **Cost of training and environmental impact**: The computational power required to train LLMs is immense, raising concerns about their environmental footprint.
- **Bias and ethical concerns**: LLMs can inadvertently propagate biases present in their training data, raising ethical questions about their deployment.

### Introduction to RAG-based LLM applications

To surmount these hurdles, Retrieval-Augmented Generation (RAG) models integrate the generative capabilities of LLMs with a retrieval component, typically a database or knowledge base, that provides up-to-date, relevant information. This approach enriches the LLM's responses with external data, not only broadening the model's knowledge but also tailoring its responses to be more specific and accurate. RAG-based applications leverage the strength of LLMs in understanding and generating language while mitigating their informational and contextual limitations.
