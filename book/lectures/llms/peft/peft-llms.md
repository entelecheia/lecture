# PEFT for LLMs

Large Language Models (LLMs) have revolutionized the field of natural language processing. Their vast sizes, ranging from millions to billions of parameters, present considerable challenges in computational resources and training costs. For instance, loading a 70 billion parameter model necessitates an immense 280 GB of GPU memory. The extensive resources and high expenses required for training these models underscore the need for more efficient methodologies. Parameter-Efficient Fine-Tuning (PEFT) emerges as a solution, offering techniques to adapt segments of these colossal models to specific tasks, thereby reducing computational burdens.

In this context, the necessity for more efficient approaches to leverage these models is clear, especially for those with limited datasets and computational resources. This is where Parameter-Efficient Fine-Tuning (PEFT) comes into play. PEFT offers a suite of techniques that enable the adaptation of small sections of these massive models to specific tasks, thereby reducing the overall computational burden.

This lecture aims to provide a comprehensive understanding of each PEFT technique currently implemented in Hugging Face, delineating the differences among them. This guide fills the gaps identified in these materials and serves as a conceptual foundation for all PEFT methods present in Hugging Face. The goal is to equip readers with a fundamental understanding of PEFT, facilitating their engagement with research literature on additional PEFT techniques.

## Standard Fine-Tuning vs. PEFT

Fine-tuning Large Language Models (LLMs) is a complex process with implications for model performance, data security, and resource utilization. The choice between standard fine-tuning and Parameter-Efficient Fine-Tuning (PEFT) depends on various factors, including data availability, computational resources, and specific use-case requirements.

### Data Security and Privacy Concerns

- **Data Retention in LLMs**: Research indicates that LLMs can retain a fraction of their training data. The risk of data retention increases with data duplication, leading to potential privacy and security issues, especially when models are externally accessible.
- **Prompt Injection Attacks**: One significant risk associated with fine-tuned LLMs is prompt injection attacks, where malicious inputs can trigger the model to reveal sensitive training data.
- **In-Context Learning (ICL) as an Alternative**: For scenarios where data security is paramount, ICL, which involves dynamic observation selection, can be a safer alternative. It allows the model to adapt to new tasks without explicit fine-tuning, reducing the risk of data leakage.

### Importance of Data Quality

- **Impact on Fine-Tuning Success**: The success of both standard and PEFT largely depends on the quality of data labels. Poorly labeled data can lead to ineffective fine-tuning, regardless of the method used.
- **Data Labeling Commitment**: High-quality data labeling is crucial, particularly for standard fine-tuning, which involves a more extensive modification of the model.

### Comparative Analysis

|                             | **Parameter-efficient Fine-tuning**                                                                     | **Standard Fine-tuning**                                                                                |
| --------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Goal**                    | Tailor a pre-trained model to specific tasks efficiently with limited data and computational resources. | Enhance model performance on specific tasks using comprehensive training with ample data and resources. |
| **Training Data**           | Optimal for scenarios with limited datasets, typically requiring fewer examples.                        | Requires large datasets with numerous examples for effective training.                                  |
| **Training Time**           | Generally offers a quicker training process due to fewer parameters being tuned.                        | Involves a longer training duration due to the extensive tuning of all model parameters.                |
| **Computational Resources** | More resource-efficient, utilizing fewer computational resources.                                       | Demands significant computational resources for processing large models and datasets.                   |
| **Model Parameters**        | Involves modifying a small, specific subset of the model's parameters.                                  | Entails re-training the entire model, adjusting all parameters.                                         |
| **Overfitting**             | Reduced risk of overfitting due to limited modifications to the model.                                  | Higher potential for overfitting as the model undergoes extensive modifications.                        |
| **Training Performance**    | Achieves good performance, although it may not match the levels attained by full fine-tuning.           | Typically yields better performance, optimizing the model's capabilities to the fullest.                |
| **Use Cases**               | Suitable for applications in low-resource settings or when extensive training data isn't available.     | Ideal for well-resourced environments with access to large amounts of training data.                    |

Selecting between standard fine-tuning and PEFT involves balancing various factors. Standard fine-tuning is more resource-intensive but can lead to higher model performance, making it suitable for scenarios with sufficient computational resources and data. In contrast, PEFT is ideal for situations where resources are limited or when working with smaller datasets. It offers a practical way to leverage the capabilities of large models without the extensive resource requirements of standard fine-tuning. Additionally, considerations of data privacy and security are crucial in deciding the most appropriate approach for fine-tuning LLMs.

## Who Uses PEFT?

Parameter-Efficient Fine-Tuning (PEFT) has garnered significant attention and adoption across various sectors of the artificial intelligence and machine learning industry, especially among entities that specialize in language model services. The appeal of PEFT lies in its ability to adapt large-scale pre-trained language models (PLMs) to specific tasks with minimal resource overhead.

### Current Adoption of PEFT

#### Hugging Face 🤗

- **Wide Range of PEFT Techniques**: Hugging Face, a prominent player in the field of AI and NLP, offers an extensive suite of PEFT techniques through its platform. This includes various innovative methods such as LoRA, Prefix Tuning, and P-Tuning, among others.
- **Open-Source Accessibility**: Hugging Face’s commitment to open-source technology has made PEFT techniques more accessible to the wider AI community, allowing researchers and developers to experiment with and implement these methods in their projects.
- **Community Contributions**: The active community around Hugging Face contributes to the continuous development and refinement of PEFT methods, ensuring they stay at the forefront of AI research and application.

#### Google's Vertex AI

- **Reference to PEFT Research**: Google’s Vertex AI, known for providing advanced machine learning services, references the survey by Liali et al. on PEFT in its tuning guide.
- **Opaque Implementation Details**: While Google acknowledges the significance of PEFT, the specifics of how Vertex AI implements these techniques are not fully disclosed. This opacity leaves room for speculation about the extent and manner of PEFT’s integration into Google's AI offerings.

#### OpenAI

- **Current Non-Implementation**: As per a now-removed blog post, OpenAI, renowned for its GPT models, has not yet incorporated PEFT methods into its suite of tools and services.
- **Potential Future Adoption**: Given OpenAI's reputation for pioneering AI research and development, it is anticipated that PEFT will eventually be part of its toolset. The adoption of PEFT by OpenAI could be driven by the increasing demand for efficient fine-tuning methods and the need to make large models like GPT more accessible and adaptable.

## Quick Transformer Review

The Transformer architecture, introduced by Vaswani et al. in their seminal paper "Attention Is All You Need," has become a cornerstone in modern natural language processing (NLP) and machine learning. This architecture is fundamental to understanding the nuances of Parameter-Efficient Fine-Tuning (PEFT) techniques.

### Core Concepts of Transformer Architecture

#### Self-Attention Mechanism

- **Principle**: At the heart of the Transformer is the self-attention mechanism, which enables the model to weigh the importance of different words in a sentence for a given task. Unlike previous architectures that processed words in sequence, the Transformer treats input data in parallel, allowing it to capture complex word relationships more effectively.
- **Functionality**: Self-attention works by creating three vectors for each input token (word): the query vector, key vector, and value vector. These vectors are derived through learned linear transformations.
- **Attention Calculation**: The attention scores are computed by taking the dot product of the query vector with key vectors of all tokens and applying a softmax function. These scores determine how much focus to put on other parts of the input sentence as each word is processed.
- **Scaled Dot-Product Attention**: The scores are then multiplied with the value vectors and summed up, resulting in the output for each token. This process is scaled by the square root of the dimension of key vectors to prevent gradients from vanishing or exploding.

#### Transformer Block Structure

- **Layers**: A standard transformer block consists of two main layers: the multi-head self-attention layer and the position-wise feed-forward network.
  - **Multi-Head Attention**: This layer extends the self-attention mechanism by having multiple ‘heads’, each performing attention calculations independently. The outputs of these heads are then concatenated and linearly transformed into the desired dimension. This multi-head approach allows the model to attend to information from different representation subspaces at different positions.
  - **Feed-Forward Network**: Following the attention layer, the output passes through a position-wise feed-forward network, typically comprising two linear transformations with an activation function in between.
- **Normalization and Residual Connections**: Each of these layers is followed by layer normalization and is equipped with residual connections. This means the output of each layer is the sum of its input and its processed result, enhancing training stability and allowing deeper networks.
- **Positional Encoding**: Since the Transformer doesn’t inherently capture the sequential nature of data, positional encodings are added to the input embeddings to give the model information about the position of each token in the sequence.

### Importance in PEFT

- **PEFT Adaptations**: Understanding the Transformer’s architecture is crucial for comprehending how PEFT techniques modify it. PEFT methods typically intervene at the level of the self-attention mechanism and the feed-forward networks, adjusting or augmenting the model’s parameters efficiently for task-specific fine-tuning.
- **Targeting Specific Components**: Depending on the PEFT technique used, modifications may be made to specific components like the attention heads or layers of the feed-forward network, enabling the fine-tuning process to be both efficient and effective with fewer trainable parameters.

## PEFT Techniques Overview

### Additive Methods

**Adapters**: Introduced by Houlsby et al., this technique involves adding small fully connected networks after Transformer sub-layers. The pseudo code for an adapted transformer block illustrates these additions.

**(IA)³**: This method, proposed by Liu et al., augments the transformer block with additional column vectors (l_k, l_v) that modify the key and value matrices in the attention mechanism. This is done without strictly adding fully connected layers, distinguishing it from traditional adapter methods.

### Soft-Prompts

**Prompt-Tuning**: Developed by Lester et al., this technique involves creating a set of parameters for prompt tokens and integrating them at the beginning of the network. It allows for optimization of a continuous representation of the prompt text.

**Prefix Tuning**: Similar to prompt tuning but differs in that the representation is fed to all layers of the transformer. It also involves learning additional parameters for the soft prompt in the form of a fully connected network.

**P-Tuning**: Proposed by Liu et al., P-Tuning encodes the prompt using an LSTM, aiming to address the discrete nature of word embeddings and their independent associations in other prompting methods.

**LLaMA-Adapter**: As per Zhang et al., this technique applies a variant of prefix learning to the Llama model. It introduces adaptation prompts and zero-initialized attention for efficient fine-tuning.

### Reparameterization-Based Methods

**LoRa**: A popular technique by Hu et al., LoRa reparameterizes a weight matrix by learning a separate matrix representing updates from optimization. It uses two smaller matrices to represent these updates, reducing the number of parameters to be learned.

### Selective Methods

**AdaLoRa**: This hybrid approach, developed by Zhang et al., combines ideas from reparameterization and selective methods. It uses an approximation of Singular Value Decomposition (SVD) to represent weight matrix updates and incorporates a pruning technique to eliminate less important singular vectors.

### Comparison of Methods

The table below provides a comparison of these methods, highlighting the number of trainable parameters, method type, and a brief summary.

| Method        | Trainable Parameters | Type               | Summary                                                   |
| ------------- | -------------------- | ------------------ | --------------------------------------------------------- |
| Adapters      | Low                  | Additive           | Adds small networks after sub-layers.                     |
| (IA)³         | Low                  | Additive           | Augments attention mechanism with additional vectors.     |
| Prompt-Tuning | Very Low             | Soft-Prompts       | Optimizes a continuous representation of the prompt text. |
| Prefix Tuning | Low                  | Soft-Prompts       | Feeds prompt representation to all transformer layers.    |
| P-Tuning      | Low                  | Soft-Prompts       | Encodes prompts using an LSTM.                            |
| LLaMA-Adapter | Low                  | Soft-Prompts       | Applies efficient prefix learning to Llama model.         |
| LoRa          | Very Low             | Reparameterization | Reparameterizes weight matrix with two smaller matrices.  |
| AdaLoRa       | Low                  | Selective/Hybrid   | Uses SVD approximation for weight matrix updates.         |

## Conclusion

Parameter-Efficient Fine-Tuning (PEFT) stands as a transformative approach in the realm of working with Large Language Models (LLMs), addressing the critical challenges of computational demand and resource constraints. By focusing on adapting smaller segments of these expansive models, PEFT offers a path to harness the power of LLMs in a more accessible and sustainable manner. This approach not only broadens the scope of who can utilize these models but also expands the potential applications in various fields.

The integration of PEFT techniques, particularly those developed and made accessible by platforms like Hugging Face, marks a significant advancement in the field of natural language processing and artificial intelligence. These techniques allow for the efficient customization of LLMs for specific tasks, providing a balance between performance and resource utilization. The diverse range of PEFT methods, including LoRA, Prefix Tuning, and AdaLoRA, each offers unique advantages, catering to different requirements and scenarios.

The potential of PEFT extends beyond just language models; its principles are being applied to other areas such as diffusion models, indicating a broad spectrum of impact. Whether it's fine-tuning for specific tasks, adapting models for resource-limited settings, or pushing the boundaries of what's possible with consumer-grade hardware, PEFT is at the forefront of this evolution.

In conclusion, PEFT represents a significant step forward in the democratization of AI and ML technologies. It opens up new avenues for innovation, allowing a wider range of researchers, developers, and organizations to leverage the capabilities of large-scale models in a more efficient and effective manner. As the field continues to evolve, the role of PEFT in shaping the future of machine learning and AI will undoubtedly be pivotal, driving forward the possibilities of what can be achieved with these powerful tools.
