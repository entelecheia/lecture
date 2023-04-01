# Meet the Camelids: A Family of LLMs

```{youtube} saNnrmlET4M
:width: 100%
```

Camelids are a remarkable family of mammals that thrive in some of the most inhospitable environments on Earth. While the camel may be the most famous of the group, lesser-known members like the llama, alpaca, vicuña, and guanaco also possess unique characteristics and adaptations that make them equally fascinating.

```{image} ../figs/nlp_advances/camelids/camelids.png
:alt: Camelids
:class: bg-primary mb-1
:width: 50%
:align: center
```

## Introduction

The world of artificial intelligence has been transformed by the emergence of large language models (LLMs), which have revolutionized natural language processing and brought about a new era of intelligent chatbot systems. As these models continue to evolve and diversify, it is essential to explore their unique capabilities, strengths, and potential applications. In this article, we introduce you to the "Camelids" – a family of groundbreaking large language models, including LLaMA, Alpaca, and Vicuna-13B, each of which has been inspired by the power and adaptability of their respective South American mammalian counterparts.

## LLAMA

by [Meta](https://ai.facebook.com/blog/large-language-model-llama-meta-ai/)

Meta has released LLaMA (Large Language Model Meta AI), a smaller and more performant foundational language model aimed at advancing research and democratizing access in the AI field. LLaMA requires less computing power and resources, making it ideal for testing new approaches, validating work, and exploring use cases. The model is available in several sizes (7B, 13B, 33B, and 65B parameters) and is accompanied by a model card detailing its construction.

Large language models have shown potential benefits at scale, but access to them is limited due to resource constraints. Smaller models like LLaMA are easier to retrain and fine-tune, facilitating research on their robustness, bias, toxicity, and potential for generating misinformation. LLaMA shares these challenges, but its release enables researchers to test new approaches to mitigate these issues.

The model is released under a noncommercial license for research use, and access will be granted on a case-by-case basis. Meta encourages collaboration among the AI community to develop guidelines around responsible AI and large language models.

## ALPACA

by [Stanford](https://crfm.stanford.edu/2023/03/13/alpaca.html)

Stanford researchers have developed an instruction-following language model called Alpaca, fine-tuned from Meta's LLaMA 7B model. Alpaca aims to address issues like false information, social stereotypes, and toxic language in instruction-following models such as GPT-3.5 and ChatGPT. The researchers are releasing their training recipe, data, and plan to release the model weights in the future. They have also created an interactive demo for the research community to understand Alpaca's behavior and identify potential improvements.

Alpaca is intended solely for academic research, and commercial use is prohibited due to its origin from LLaMA's non-commercial license, usage restrictions from OpenAI's text-davinci-003, and a lack of adequate safety measures for general deployment.

## VICUÑA

by the [team with members from UC Berkeley, CMU, Stanford, and UC San Diego](https://vicuna.lmsys.org/)

Vicuna-13B is an open-source chatbot inspired by Meta's LLaMA and Stanford's Alpaca project. It is fine-tuned on a LLaMA base model using user-shared conversations from ShareGPT.com. The training scripts were enhanced to handle multi-round conversations and long sequences, with training completed in one day using PyTorch FSDP on 8 A100 GPUs. A lightweight distributed serving system was implemented for the demo. To evaluate the model quality, 80 diverse questions were created, and GPT-4 was used to judge the model outputs. Vicuna-13B has demonstrated competitive performance compared to other open-source models like Stanford Alpaca, and an online demo is available for the community to test the chatbot's capabilities.

## GUANACO

Comming soon...

## References

- [Llama](https://ai.facebook.com/blog/large-language-model-llama-meta-ai/)
- [Alpaca](https://crfm.stanford.edu/2023/03/13/alpaca.html)
- [Vicuña](https://vicuna.lmsys.org/)
