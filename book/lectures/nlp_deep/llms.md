# Large Language Models

## Introduction

- Definition: Large Language Models (LLMs) are advanced machine learning models, primarily based on deep learning, designed to understand and generate human-like text.
- Capabilities: LLMs can perform a wide range of tasks, such as translation, summarization, answering questions, and generating text.
- Methodologies: LLMs are primarily based on the Transformer architecture and trained using unsupervised learning on massive text corpora.

## Definition of Large Language Models (LLMs)

- LLMs are neural network-based models, specifically designed to process, understand, and generate human-like text
- Built on the Transformer architecture, which allows for parallel processing and efficient learning of long-range dependencies
- Examples include GPT-3, BERT, and T5

## Capabilities of LLMs

- Natural language understanding and generation
- Sentiment analysis and text classification
- Language translation
- Text summarization
- Question-answering
- Conversational AI
- Code generation and completion
- Domain-specific knowledge extraction

## Methodologies

- Transformer architecture: Key component of LLMs, enables efficient learning of long-range dependencies and parallel processing
- Attention mechanism: Weights the importance of different words in the input, improves context understanding
- Pre-training: LLMs are pre-trained on large-scale text corpora, learning grammar, facts, and reasoning abilities
- Fine-tuning: LLMs can be fine-tuned on specific tasks or domains, enhancing their performance on targeted problems

## Applications

- Chatbots and virtual assistants
- Content generation and journalism
- Language translation services
- Information retrieval and summarization
- Sentiment analysis for market research
- Code generation and debugging
- Education and tutoring

## Surrounding Issues

- Ethical concerns: Potential for generating biased, offensive, or harmful content
- Data privacy: LLMs can inadvertently memorize sensitive information present in the training data
- Environmental impact: Training LLMs consumes significant computational resources and energy
- Accessibility: LLMs require substantial resources, potentially limiting their use by smaller organizations and individuals
- Explainability: Understanding the reasoning behind LLM-generated outputs remains a challenge

## Emergent abilities of large language models

{cite:t}`wei2022emergent` defined an emergent ability as an ability that is “not present in small models but is present in large models.”

```{figure} ../figs/deep_nlp/llms/llm_ablities.png
---
width: 60%
name: fig-llm-ablities
---
Eight examples of emergence in the few-shot prompting setting.
```

Emergence in large language models refers to abilities not present in small models but found in larger ones. Over 100 examples of emergent abilities have been discovered in models like GPT-3, Chinchilla, and PaLM. These abilities can be classified into two categories: emergent few-shot prompted tasks and emergent prompting strategies.

Emergent few-shot prompted tasks are tasks where small models perform at random chance, while large models perform well above-random. Sources for these tasks include BIG-Bench, the Massive Multitask Benchmark, and several papers showcasing individual tasks as emergent abilities.

Emergent prompting strategies are general prompting strategies that work only for sufficiently large-scale language models. Examples include instruction-following, scratchpad, chain-of-thought prompting, and leveraging explanations in prompting.

Promising future research directions include improving model architectures, enhancing data quality and quantity, optimizing prompting, exploring frontier tasks, and understanding why emergent abilities occur and if they can be predicted.

### BIG-Bench (67 tasks):

- GPT-3 13B (2 tasks): hindu knowledge, modified arithmetic
- GPT-3 175B (15 tasks): analytic entailment, codenames, etc.
- LaMDA 137B (8 tasks): gender inclusive sentences german, repeat copy logic, etc.
- PaLM 8B (3 tasks): auto debugging, sufficient information, parsinlu reading comprehension
- PaLM 64B (14 tasks): anachronisms, ascii word recognition, etc.
- PaLM 540B (25 tasks): analogical similarity, causal judgment, etc.

### MMLU (51 tasks; see Chinchilla paper for results):

- Chinchilla 7B (7 tasks): Professional Medicine, High School Statistics, etc.
- Chinchilla 70B (44 tasks): International Law, Human Aging, etc.

### Individual emergent tasks from papers:

- GPT-3 paper: 3 digit addition/subtraction (GPT-3 13B), 4-5 digit addition/substraction (GPT-3 175B), leveraging few-shot examples for word denoising (GPT-3 13B)
- Gopher paper: Toxicity classification (Gopher 7.1B), TruthfulQA (Gopher 280B)
- Patel & Pavlick: grounded conceptual mappings (GPT-3 175B)
- PaLM paper: Word in Context benchmark (PaLM 540B)
