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

```python
def self_attention(x):
    # Project the input to create key (k), query (q), and value (v) matrices
    k = x @ W_k  # Key matrix is obtained by multiplying the input with weight W_k
    q = x @ W_q  # Query matrix is obtained by multiplying the input with weight W_q
    v = x @ W_v  # Value matrix is obtained by multiplying the input with weight W_v

    # Calculate the attention scores and apply them to the value matrix
    # Softmax is applied to the dot product of q and the transpose of k for normalization
    # The resulting attention scores are then multiplied with the value matrix v
    return softmax(q @ k.T) @ v

def transformer_block(x):
    # Store the original input for the residual connection
    residual = x

    # Apply self-attention to the input
    x = self_attention(x)

    # Add the residual (original input) to the output of the self-attention layer
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Store the output of the first sub-layer for the next residual connection
    residual = x

    # Apply the Feed-Forward Network (FFN) to the output of the first sub-layer
    x = FFN(x)

    # Add the residual (output of the first sub-layer) to the output of the FFN
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Return the output of the transformer block
    return x
```

In this code snippet, the `self_attention` function defines the self-attention mechanism used in transformer models, projecting input `x` into key, query, and value matrices and applying the attention mechanism. The `transformer_block` function represents a single block of a transformer model, which includes a self-attention layer followed by a feed-forward network (FFN), both supplemented with residual connections and layer normalization for stability and performance improvement.

### Importance in PEFT

- **PEFT Adaptations**: Understanding the Transformer’s architecture is crucial for comprehending how PEFT techniques modify it. PEFT methods typically intervene at the level of the self-attention mechanism and the feed-forward networks, adjusting or augmenting the model’s parameters efficiently for task-specific fine-tuning.
- **Targeting Specific Components**: Depending on the PEFT technique used, modifications may be made to specific components like the attention heads or layers of the feed-forward network, enabling the fine-tuning process to be both efficient and effective with fewer trainable parameters.

## PEFT Techniques Overview

### Additive Methods

**Adapters**: Introduced by Houlsby et al., this technique involves adding small fully connected networks after Transformer sub-layers. The pseudo code for an adapted transformer block illustrates these additions.

```python
def transformer_block_adapter(x):
    # Store the original input for the residual connection
    residual = x

    # Apply self-attention to the input
    x = self_attention(x)

    # Apply the first Feed-Forward Network (FFN), which acts as an adapter in this context
    # Adapters are small networks added after the transformer sub-layers
    x = FFN(x)  # Adapter layer

    # Add the residual (original input) to the output of the adapter layer
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Store the output of the first sub-layer (including the adapter) for the next residual connection
    residual = x

    # Apply the second Feed-Forward Network (FFN) for further transformation
    x = FFN(x)

    # Apply another adapter after the second FFN
    x = FFN(x)  # Second adapter layer

    # Add the residual (output of the first adapter layer) to the output of the second adapter layer
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Return the output of the transformer block with adapters
    return x
```

In this code snippet, the `transformer_block_adapter` function represents a transformer block modified to include adapters, as introduced by Houlsby et al. Adapters are additional small feed-forward networks inserted after each sub-layer within the transformer block (after self-attention and the original FFN). These adapters provide a means to fine-tune the pre-trained transformer models efficiently by only training the parameters within these adapter layers, rather than the entire model. This approach helps in adapting the model to specific tasks while keeping the computational overhead low.

**(IA)³**: This method, proposed by Liu et al., augments the transformer block with additional column vectors ($l_k$, $l_v$) that modify the key and value matrices in the attention mechanism. This is done without strictly adding fully connected layers, distinguishing it from traditional adapter methods.

```python
def self_attention_ia3(x):
    # Project the input to create key (k), query (q), and value (v) matrices
    k = x @ W_k  # Key matrix is obtained by multiplying the input with weight W_k
    q = x @ W_q  # Query matrix is obtained by multiplying the input with weight W_q
    v = x @ W_v  # Value matrix is obtained by multiplying the input with weight W_v

    # IA³ augmentation: Modify the key and value matrices using additional column vectors l_k and l_v
    # These additional vectors allow for specific adjustments to the attention mechanism
    k = l_k @ k  # Modify key matrix with l_k vector
    v = l_v @ v  # Modify value matrix with l_v vector

    # Calculate the attention scores and apply them to the value matrix
    # Softmax is applied to the dot product of q and the transpose of k for normalization
    # The resulting attention scores are then multiplied with the value matrix v
    return softmax(q @ k.T) @ v

def transformer_block_ia3(x):
    # Store the original input for the residual connection
    residual = x

    # Apply the IA³-augmented self-attention to the input
    x = self_attention_ia3(x)

    # Add the residual (original input) to the output of the self-attention layer
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Store the output of the first sub-layer for the next residual connection
    residual = x

    # Apply the first part of the Feed-Forward Network (FFN)
    x = x @ W_1  # Normal transformer feed-forward operation

    # IA³ augmentation for the Feed-Forward Network
    # Apply an element-wise multiplication with the l_ff vector after applying the GELU activation function
    # This step introduces adaptability specific to the IA³ approach
    x = l_ff * gelu(x)  # Modify FFN output with l_ff vector

    # Complete the FFN operation
    x = x @ W_2

    # Add the residual (output of the first sub-layer) to the output of the FFN
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Return the output of the transformer block with IA³ modifications
    return x
```

In this code snippet, the `self_attention_ia3` function and the `transformer_block_ia3` function represent the IA³ method as proposed by Liu et al. The IA³ method augments the standard Transformer architecture by introducing additional column vectors to modify the key and value matrices in the self-attention mechanism, as well as applying modifications to the feed-forward network. This approach allows for targeted adjustments to the model's attention and feed-forward mechanisms, enhancing its adaptability for specific tasks without adding fully connected layers typical of traditional adapter methods.

### Soft-Prompts

**Prompt-Tuning**: Developed by Lester et al., this technique involves creating a set of parameters for prompt tokens and integrating them at the beginning of the network. It allows for optimization of a continuous representation of the prompt text.

```python
def prompt_tuning(seq_tokens, prompt_tokens):
    # Create embeddings for the input sequence tokens
    # seq_embedding is a function that transforms sequence tokens into their corresponding embeddings
    x = seq_embedding(seq_tokens)

    # Create soft prompt embeddings
    # prompt_embedding is a function that creates embeddings for a set of trainable prompt tokens
    # These prompt tokens are not part of the original input but are learned parameters that are optimized during training
    soft_prompt = prompt_embedding(prompt_tokens)

    # Concatenate the soft prompt embeddings with the input sequence embeddings
    # This operation combines the prompt information with the actual input, allowing the model to consider the prompt context
    # 'dim=seq' specifies the dimension along which the concatenation occurs, typically the sequence length dimension
    model_input = concat([soft_prompt, x], dim=seq)

    # Pass the concatenated input through the model
    # The model processes the combined prompt and sequence input, utilizing the prompt context for better adaptation to the task
    return model(model_input)
```

In this code snippet, `prompt_tuning` function represents the Prompt-Tuning technique as developed by Lester et al. This approach involves integrating a set of learned prompt tokens at the beginning of the input sequence. These prompt tokens, represented as "soft prompts," are not fixed but are trainable parameters that are optimized during the training process. By concatenating these soft prompt embeddings with the input sequence embeddings, the model is provided with additional context or guidance, enhancing its ability to adapt to specific tasks or datasets. This method allows for the fine-tuning of large language models in a parameter-efficient manner, as only the prompt embeddings are trained, leaving the rest of the model's parameters frozen.

**Prefix Tuning**: Similar to prompt tuning but differs in that the representation is fed to all layers of the transformer. It also involves learning additional parameters for the soft prompt in the form of a fully connected network.

```python
def transformer_block_prefix_tuning(x, soft_prompt):
    # Apply a Feed-Forward Network (FFN) to the soft prompt
    # The FFN is used to transform the soft prompt embeddings, allowing for more complex and adaptable representations
    # This FFN is part of the learnable parameters and is specific to the prefix tuning method
    soft_prompt = FFN(soft_prompt)

    # Concatenate the transformed soft prompt embeddings with the input sequence embeddings
    # Unlike prompt tuning where the prompt is only added at the beginning, in prefix tuning
    # the transformed soft prompt is designed to be integrated with every layer of the transformer
    # 'dim=seq' specifies the dimension along which the concatenation occurs, typically the sequence length dimension
    model_input = concat([soft_prompt, x], dim=seq)

    # Pass the concatenated input (including the soft prompt) through the model
    # The transformer model processes the input sequence along with the embedded prompts,
    # allowing each layer of the transformer to utilize the prompt information
    return model(model_input)
```

In this code snippet, the `transformer_block_prefix_tuning` function represents the Prefix Tuning technique. Prefix Tuning is similar to Prompt Tuning in that it involves adding soft prompts to the input. However, it differs significantly in its approach to integrating these prompts. In Prefix Tuning, the soft prompts are first transformed by a Feed-Forward Network (FFN), and this transformed representation is then concatenated with the input sequence embeddings. This concatenated input is fed to every layer of the transformer model, as opposed to just the beginning of the model in standard Prompt Tuning. This method allows for a more extensive and integrated use of the prompt information throughout the model, potentially leading to more nuanced and effective adaptations to specific tasks or datasets.

**P-Tuning**: Proposed by Liu et al., P-Tuning encodes the prompt using an LSTM, aiming to address the discrete nature of word embeddings and their independent associations in other prompting methods.

```python
def p_tuning(seq_tokens, prompt_tokens):
    # Create embeddings for the prompt tokens
    # prompt_embedding is a function that transforms prompt tokens into their corresponding embeddings
    # These prompt tokens are learnable parameters that are optimized during training
    h = prompt_embedding(prompt_tokens)

    # Process the prompt embeddings with a bidirectional LSTM
    # The LSTM (Long Short-Term Memory) network is used to capture sequential information in the prompts
    # and can model dependencies in both forward and reverse directions (bidirectional)
    h = LSMT(h, bidirectional=True)

    # Apply a Feed-Forward Network (FFN) to the output of the LSTM
    # This step further transforms the prompt embeddings, allowing for richer representations
    h = FFN(h)

    # Create embeddings for the input sequence tokens
    # seq_embedding is a function that transforms sequence tokens into their corresponding embeddings
    x = seq_embedding(seq_tokens)

    # Concatenate the transformed prompt embeddings (h) with the input sequence embeddings (x)
    # This operation combines the prompt information with the actual input sequence
    # 'dim=seq' specifies the dimension along which the concatenation occurs, typically the sequence length dimension
    model_input = concat([h, x], dim=seq)

    # Pass the concatenated input (including the prompt embeddings) through the model
    # The transformer model processes the input sequence along with the embedded prompts
    return model(model_input)
```

In this code snippet, the `p_tuning` function represents the P-Tuning technique as proposed by Liu et al. P-Tuning aims to address the limitations of other prompting methods by using an LSTM network to encode the prompts. This approach helps to capture the sequential nature and dependencies within the prompt embeddings more effectively. The prompt embeddings are first transformed by the LSTM and then further processed by a Feed-Forward Network (FFN) to enrich their representation. These transformed prompt embeddings are then concatenated with the input sequence embeddings, and the combined input is fed into the model. This method allows for a more nuanced integration of the prompt information into the model, potentially leading to more effective adaptations for specific tasks.

**LLaMA-Adapter**: As per Zhang et al., this technique applies a variant of prefix learning to the Llama model. It introduces adaptation prompts and zero-initialized attention for efficient fine-tuning.

```python
def transformer_block_llama_adapter(x, soft_prompt, gating_factor):
    # Store the original input for the residual connection
    residual = x

    # Create an adaptation prompt by concatenating the soft prompt with the input
    # This adaptation prompt is a modification specific to the LLaMA-Adapter approach
    adaption_prompt = concat([soft_prompt, x], dim=seq)

    # Apply self-attention to the adaptation prompt
    # The self-attention mechanism processes the combined input of soft prompts and sequence tokens
    adaption_prompt = self_attention(adaption_prompt)

    # Apply gating to the adaptation prompt using a zero-initialized attention mechanism
    # This gating factor controls the influence of the adaptation prompt on the transformer block
    # The zero-init attention helps in starting the training from a state where the adaptation prompt has minimal impact,
    # gradually learning its influence during training
    adaption_prompt = adaption_prompt * gating_factor

    # Apply self-attention to the original input sequence
    x = self_attention(x)

    # Combine the output of the self-attention with the adapted prompt
    # The element-wise multiplication integrates the adaptation prompt into the main data flow
    x = adaption_prompt * x

    # Add the residual (original input) to the output of the combined self-attention and adaptation prompt
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Store the output of the first sub-layer for the next residual connection
    residual = x

    # Apply the Feed-Forward Network (FFN) to the output of the first sub-layer
    x = FFN(x)

    # Add the residual (output of the first sub-layer) to the output of the FFN
    # and apply layer normalization
    x = layer_norm(x + residual)

    # Return the output of the transformer block with the LLaMA-Adapter modifications
    return x
```

In this code snippet, the `transformer_block_llama_adapter` function represents the implementation of the LLaMA-Adapter technique. This method applies a variant of prefix learning to the transformer model, incorporating adaptation prompts and a zero-initialized attention mechanism. The adaptation prompt, created by combining soft prompts with the input sequence, is processed through self-attention and then modulated by a gating factor. This approach allows for efficient fine-tuning by introducing an adaptable mechanism that initially has minimal impact but learns to influence the transformer block's processing over the course of training. The LLaMA-Adapter thus provides a novel way to fine-tune transformer models, enhancing their adaptability to specific tasks while maintaining the underlying model structure.

### Reparameterization-Based Methods

**LoRa**: A popular technique by Hu et al., LoRa reparameterizes a weight matrix by learning a separate matrix representing updates from optimization. It uses two smaller matrices to represent these updates, reducing the number of parameters to be learned.

```python
def lora_linear(x, W):
    # Scale factor based on the rank r
    # In LoRa, a low-rank approximation is used to reduce the number of learnable parameters
    # r is the rank, which is a hyperparameter determining the size of the low-rank matrices W_a and W_b
    scale = 1 / r

    # Standard linear transformation using the original weight matrix W
    h = x @ W

    # LoRa modification: Apply low-rank linear transformation
    # W_a and W_b are smaller matrices representing updates from optimization
    # The product of W_a and W_b approximates the updates to the original weight matrix W
    # This approach reduces the number of parameters to learn, focusing on the most impactful parts of W
    h += x @ W_a @ W_b

    # Scale the result of the transformation
    # The scaling helps in balancing the influence of the low-rank approximation
    return scale * h

def self_attention_lora(x):
    # Apply the LoRa-modified linear transformation to the key and value matrices
    # LoRa reparameterizes the original weight matrices (W_k and W_v) of the key and value vectors
    k = lora_linear(x, W_k)  # LoRa applied to key matrix
    q = x @ W_q              # Standard linear transformation for query matrix
    v = lora_linear(x, W_v)  # LoRa applied to value matrix

    # Calculate the attention scores and apply them to the value matrix
    # The attention mechanism remains the same as in the standard self-attention
    # The key and value matrices are modified by LoRa, allowing for efficient learning of the most impactful parameters
    return softmax(q @ k.T) @ v
```

In this code snippet, the `lora_linear` function implements the Low-Rank Adaptation (LoRa) technique for linear layers, and the `self_attention_lora` function integrates this technique into the self-attention mechanism of a transformer. LoRa focuses on reparameterizing the weight matrices of the key and value vectors using low-rank matrices. By learning updates in the form of smaller matrices (W_a and W_b), LoRa efficiently captures the most significant changes to the weights while reducing the overall number of parameters that need to be learned. This approach maintains the core functionality of the self-attention mechanism while allowing for more efficient and focused training, particularly beneficial for adapting large pre-trained models to new tasks or datasets.

### Selective Methods

**AdaLoRa**: This hybrid approach, developed by Zhang et al., combines ideas from reparameterization and selective methods. It uses an approximation of Singular Value Decomposition (SVD) to represent weight matrix updates and incorporates a pruning technique to eliminate less important singular vectors.

```python
def adalora_linear(x, W, curr_sv):
    # Scale factor based on the rank r
    # In AdaLoRa, a low-rank approximation with a scaling factor is used
    # r is the rank and alpha is a scaling hyperparameter
    scale = alpha / r

    # Standard linear transformation using the original weight matrix W
    h = x @ W

    # AdaLoRa modification: Apply low-rank linear transformation using SVD components
    # p, lambda, and q are matrices derived from the singular value decomposition (SVD) of W
    # curr_sv represents the current singular vectors being optimized
    # This approach selectively updates the weight matrix W focusing on its most significant singular vectors
    h += x @ p[curr_sv] @ lamda[curr_sv] @ q[curr_sv]

    # Scale the result of the transformation
    return scale * h

def self_attention_adalora(x):
    """
    AdaLoRa-specific self-attention mechanism.
    This function shows how AdaLoRa is integrated into the self-attention block.
    It does not include the pruning techniques used in AdaLoRa.
    """
    # Apply the AdaLoRa-modified linear transformation to the key and value matrices
    # AdaLoRa reparameterizes the original weight matrices (W_k and W_v) of the key and value vectors
    k = adalora_linear(x, W_k)  # AdaLoRa applied to key matrix
    q = x @ W_q                 # Standard linear transformation for query matrix
    v = adalora_linear(x, W_v)  # AdaLoRa applied to value matrix

    # Calculate the attention scores and apply them to the value matrix
    # The attention mechanism remains the same as in standard self-attention
    # The key and value matrices are modified by AdaLoRa, focusing on efficient learning of significant parameters
    return softmax(q @ k.T) @ v
```

In this code snippet, the `adalora_linear` function implements the AdaLoRa technique for linear layers, and the `self_attention_adalora` function integrates AdaLoRa into the self-attention mechanism of a transformer. AdaLoRa combines ideas from reparameterization with selective methods, using an approximation of Singular Value Decomposition (SVD) to represent weight matrix updates. This method focuses on optimizing the most significant components of the weight matrices, identified through SVD, and incorporates a scaling factor for effective learning. By selectively updating these key components, AdaLoRa provides an efficient way to fine-tune large pre-trained models, targeting the adjustments that have the most substantial impact on model performance. This approach is particularly beneficial for resource-efficient training and adapting models to new tasks while maintaining their underlying structure.

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
