# PEFT for LLMs

Large Language Models (LLMs) have revolutionized the field of natural language processing. Their vast sizes, ranging from millions to billions of parameters, present considerable challenges in computational resources and training costs. For instance, loading a 70 billion parameter model necessitates an immense 280 GB of GPU memory. The extensive resources and high expenses required for training these models underscore the need for more efficient methodologies. Parameter-Efficient Fine-Tuning (PEFT) emerges as a solution, offering techniques to adapt segments of these colossal models to specific tasks, thereby reducing computational burdens.

In this context, the necessity for more efficient approaches to leverage these models is clear, especially for those with limited datasets and computational resources. This is where Parameter-Efficient Fine-Tuning (PEFT) comes into play. PEFT offers a suite of techniques that enable the adaptation of small sections of these massive models to specific tasks, thereby reducing the overall computational burden.

This lecture aims to provide a comprehensive understanding of each PEFT technique currently implemented in Hugging Face, delineating the differences among them. This guide fills the gaps identified in these materials and serves as a conceptual foundation for all PEFT methods present in Hugging Face. The goal is to equip readers with a fundamental understanding of PEFT, facilitating their engagement with research literature on additional PEFT techniques.

## Standard Fine-Tuning vs. Parameter-Efficient Fine-Tuning (PEFT)

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

## [PEFT in HuggingFace Libraries](https://github.com/huggingface/peft)

PEFT methods are seamlessly integrated with 🤗 Accelerate, supporting large-scale models through DeepSpeed and Big Model Inference.

### Supported PEFT Methods

1. **LoRA**: Low-Rank Adaptation for efficient model adaptation. [Paper](https://arxiv.org/abs/2106.09685)
2. **Prefix Tuning**: Optimizes continuous prompts for generation tasks. [Paper1](https://aclanthology.org/2021.acl-long.353/), [Paper2](https://arxiv.org/pdf/2110.07602.pdf)
3. **P-Tuning**: Utilizes prompts for understanding model behavior. [Paper](https://arxiv.org/abs/2103.10385)
4. **Prompt Tuning**: Harnesses the power of scale for parameter-efficient prompt tuning. [Paper](https://arxiv.org/abs/2104.08691)
5. **AdaLoRA**: Adaptive Budget Allocation for fine-tuning. [Paper](https://arxiv.org/abs/2303.10512)
6. **$(IA)^3$**: Enhances fine-tuning effectiveness and efficiency. [Paper](https://arxiv.org/abs/2205.05638)
7. **MultiTask Prompt Tuning**: Enables transfer learning across multiple tasks. [Paper](https://arxiv.org/abs/2303.02861)
8. **LoHa**: Combines Low-Rank and Hadamard Product for efficient learning. [Paper](https://arxiv.org/abs/2108.06098)
9. **LoKr**: Incorporates Kronecker Adapter for tuning. [Paper](https://arxiv.org/abs/2212.10650)

### Getting Started with PEFT

Here's a Python snippet demonstrating how to use LoRA with a sequence-to-sequence model:

```python
from transformers import AutoModelForSeq2SeqLM
from peft import get_peft_config, get_peft_model, LoraConfig, TaskType
model_name_or_path = "bigscience/mt0-large"
tokenizer_name_or_path = "bigscience/mt0-large"

peft_config = LoraConfig(
    task_type=TaskType.SEQ_2_SEQ_LM, inference_mode=False, r=8, lora_alpha=32, lora_dropout=0.1
)

model = AutoModelForSeq2SeqLM.from_pretrained(model_name_or_path)
model = get_peft_model(model, peft_config)
model.print_trainable_parameters()
# output: trainable params: 2359296 || all params: 1231940608 || trainable%: 0.19151053100118282
```

### Use Cases

#### Get comparable performance to full finetuning by adapting LLMs to downstream tasks using consumer hardware

GPU memory required for adapting LLMs on the few-shot dataset [`ought/raft/twitter_complaints`](https://huggingface.co/datasets/ought/raft/viewer/twitter_complaints). Here, settings considered
are full finetuning, PEFT-LoRA using plain PyTorch and PEFT-LoRA using DeepSpeed with CPU Offloading.

Hardware: Single A100 80GB GPU with CPU RAM above 64GB

| Model                             | Full Finetuning          | PEFT-LoRA PyTorch       | PEFT-LoRA DeepSpeed with CPU Offloading |
| --------------------------------- | ------------------------ | ----------------------- | --------------------------------------- |
| bigscience/T0_3B (3B params)      | 47.14GB GPU / 2.96GB CPU | 14.4GB GPU / 2.96GB CPU | 9.8GB GPU / 17.8GB CPU                  |
| bigscience/mt0-xxl (12B params)   | OOM GPU                  | 56GB GPU / 3GB CPU      | 22GB GPU / 52GB CPU                     |
| bigscience/bloomz-7b1 (7B params) | OOM GPU                  | 32GB GPU / 3.8GB CPU    | 18.1GB GPU / 35GB CPU                   |

Performance of PEFT-LoRA tuned [`bigscience/T0_3B`](https://huggingface.co/bigscience/T0_3B) on [`ought/raft/twitter_complaints`](https://huggingface.co/datasets/ought/raft/viewer/twitter_complaints) leaderboard.
A point to note is that we didn't try to squeeze performance by playing around with input instruction templates, LoRA hyperparams and other training related hyperparams. Also, we didn't use the larger 13B [mt0-xxl](https://huggingface.co/bigscience/mt0-xxl) model.
So, we are already seeing comparable performance to SoTA with parameter efficient tuning. Also, the final additional checkpoint size is just `19MB` in comparison to `11GB` size of the backbone [`bigscience/T0_3B`](https://huggingface.co/bigscience/T0_3B) model, but one still has to load the original full size model.

| Submission Name               | Accuracy |
| ----------------------------- | -------- |
| Human baseline (crowdsourced) | 0.897    |
| Flan-T5                       | 0.892    |
| lora-t0-3b                    | 0.863    |

**Therefore, we can see that performance comparable to SoTA is achievable by PEFT methods with consumer hardware such as 16GB and 24GB GPUs.**

An insightful blogpost explaining the advantages of using PEFT for fine-tuning FlanT5-XXL: [https://www.philschmid.de/fine-tune-flan-t5-peft](https://www.philschmid.de/fine-tune-flan-t5-peft)

### Parameter Efficient Tuning of Diffusion Models

GPU memory required by different settings during training is given below. The final checkpoint size is `8.8 MB`.

Hardware: Single A100 80GB GPU with CPU RAM above 64GB

| Model                         | Full Finetuning         | PEFT-LoRA               | PEFT-LoRA with Gradient Checkpointing |
| ----------------------------- | ----------------------- | ----------------------- | ------------------------------------- |
| CompVis/stable-diffusion-v1-4 | 27.5GB GPU / 3.97GB CPU | 15.5GB GPU / 3.84GB CPU | 8.12GB GPU / 3.77GB CPU               |

**Training**
An example of using LoRA for parameter efficient dreambooth training is given in [`examples/lora_dreambooth/train_dreambooth.py`](examples/lora_dreambooth/train_dreambooth.py)

```bash
export MODEL_NAME= "CompVis/stable-diffusion-v1-4" #"stabilityai/stable-diffusion-2-1"
export INSTANCE_DIR="path-to-instance-images"
export CLASS_DIR="path-to-class-images"
export OUTPUT_DIR="path-to-save-model"

accelerate launch train_dreambooth.py \
  --pretrained_model_name_or_path=$MODEL_NAME  \
  --instance_data_dir=$INSTANCE_DIR \
  --class_data_dir=$CLASS_DIR \
  --output_dir=$OUTPUT_DIR \
  --train_text_encoder \
  --with_prior_preservation --prior_loss_weight=1.0 \
  --instance_prompt="a photo of sks dog" \
  --class_prompt="a photo of dog" \
  --resolution=512 \
  --train_batch_size=1 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --num_class_images=200 \
  --use_lora \
  --lora_r 16 \
  --lora_alpha 27 \
  --lora_text_encoder_r 16 \
  --lora_text_encoder_alpha 17 \
  --learning_rate=1e-4 \
  --gradient_accumulation_steps=1 \
  --gradient_checkpointing \
  --max_train_steps=800
```

Try out the 🤗 Gradio Space which should run seamlessly on a T4 instance:
[smangrul/peft-lora-sd-dreambooth](https://huggingface.co/spaces/smangrul/peft-lora-sd-dreambooth).

![peft lora dreambooth gradio space](https://huggingface.co/datasets/huggingface/documentation-images/resolve/main/peft/peft_lora_dreambooth_gradio_space.png)

**NEW** ✨ Multi Adapter support and combining multiple LoRA adapters in a weighted combination
![peft lora dreambooth weighted adapter](https://huggingface.co/datasets/huggingface/documentation-images/resolve/main/peft/weighted_adapter_dreambooth_lora.png)

**NEW** ✨ Dreambooth training for Stable Diffusion using LoHa and LoKr adapters [`examples/stable_diffusion/train_dreambooth.py`](examples/stable_diffusion/train_dreambooth.py)

### Parameter Efficient Tuning of LLMs for RLHF components such as Ranker and Policy

- Here is an example in [trl](https://github.com/lvwerra/trl) library using PEFT+INT8 for tuning policy model: [gpt2-sentiment_peft.py](https://github.com/lvwerra/trl/blob/main/examples/sentiment/scripts/gpt2-sentiment_peft.py) and corresponding [Blog](https://huggingface.co/blog/trl-peft)
- Example using PEFT for Instruction finetuning, reward model and policy : [stack_llama](https://github.com/lvwerra/trl/tree/main/examples/research_projects/stack_llama/scripts) and corresponding [Blog](https://huggingface.co/blog/stackllama)

### INT8 training of large models in Colab using PEFT LoRA and bits_and_bytes

- Here is now a demo on how to fine tune [OPT-6.7b](https://huggingface.co/facebook/opt-6.7b) (14GB in fp16) in a Google Colab: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1jCkpikz0J2o20FBQmYmAGdiKmJGOMo-o?usp=sharing)

- Here is now a demo on how to fine tune [whisper-large](https://huggingface.co/openai/whisper-large-v2) (1.5B params) (14GB in fp16) in a Google Colab: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1DOkD_5OUjFa0r5Ik3SgywJLJtEo2qLxO?usp=sharing) and [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1vhF8yueFqha3Y3CpTHN6q9EVcII9EYzs?usp=sharing)

#### Save compute and storage even for medium and small models

Save storage by avoiding full finetuning of models on each of the downstream tasks/datasets,
With PEFT methods, users only need to store tiny checkpoints in the order of `MBs` all the while retaining
performance comparable to full finetuning.

An example of using LoRA for the task of adapting `LayoutLMForTokenClassification` on `FUNSD` dataset is given in `~examples/token_classification/PEFT_LoRA_LayoutLMForTokenClassification_on_FUNSD.py`. We can observe that with only `0.62 %` of parameters being trainable, we achieve performance (F1 0.777) comparable to full finetuning (F1 0.786) (without any hyperparam tuning runs for extracting more performance), and the checkpoint of this is only `2.8MB`. Now, if there are `N` such datasets, just have these PEFT models one for each dataset and save a lot of storage without having to worry about the problem of catastrophic forgetting or overfitting of backbone/base model.

Another example is fine-tuning [`roberta-large`](https://huggingface.co/roberta-large) on [`MRPC` GLUE](https://huggingface.co/datasets/glue/viewer/mrpc) dataset using different PEFT methods. The notebooks are given in `~examples/sequence_classification`.

### PEFT + 🤗 Accelerate

PEFT models work with 🤗 Accelerate out of the box. Use 🤗 Accelerate for Distributed training on various hardware such as GPUs, Apple Silicon devices, etc during training.
Use 🤗 Accelerate for inferencing on consumer hardware with small resources.

#### Example of PEFT model training using 🤗 Accelerate's DeepSpeed integration

DeepSpeed version required `v0.8.0`. An example is provided in `~examples/conditional_generation/peft_lora_seq2seq_accelerate_ds_zero3_offload.py`.
a. First, run `accelerate config --config_file ds_zero3_cpu.yaml` and answer the questionnaire.
Below are the contents of the config file.

```yaml
compute_environment: LOCAL_MACHINE
deepspeed_config:
  gradient_accumulation_steps: 1
  gradient_clipping: 1.0
  offload_optimizer_device: cpu
  offload_param_device: cpu
  zero3_init_flag: true
  zero3_save_16bit_model: true
  zero_stage: 3
distributed_type: DEEPSPEED
downcast_bf16: "no"
dynamo_backend: "NO"
fsdp_config: {}
machine_rank: 0
main_training_function: main
megatron_lm_config: {}
mixed_precision: "no"
num_machines: 1
num_processes: 1
rdzv_backend: static
same_network: true
use_cpu: false
```

b. run the below command to launch the example script

```bash
accelerate launch --config_file ds_zero3_cpu.yaml examples/peft_lora_seq2seq_accelerate_ds_zero3_offload.py
```

c. output logs:

```bash
GPU Memory before entering the train : 1916
GPU Memory consumed at the end of the train (end-begin): 66
GPU Peak Memory consumed during the train (max-begin): 7488
GPU Total Peak Memory consumed during the train (max): 9404
CPU Memory before entering the train : 19411
CPU Memory consumed at the end of the train (end-begin): 0
CPU Peak Memory consumed during the train (max-begin): 0
CPU Total Peak Memory consumed during the train (max): 19411
epoch=4: train_ppl=tensor(1.0705, device='cuda:0') train_epoch_loss=tensor(0.0681, device='cuda:0')
100%|████████████████████████████████████████████████████████████████████████████████████████████| 7/7 [00:27<00:00,  3.92s/it]
GPU Memory before entering the eval : 1982
GPU Memory consumed at the end of the eval (end-begin): -66
GPU Peak Memory consumed during the eval (max-begin): 672
GPU Total Peak Memory consumed during the eval (max): 2654
CPU Memory before entering the eval : 19411
CPU Memory consumed at the end of the eval (end-begin): 0
CPU Peak Memory consumed during the eval (max-begin): 0
CPU Total Peak Memory consumed during the eval (max): 19411
accuracy=100.0
eval_preds[:10]=['no complaint', 'no complaint', 'complaint', 'complaint', 'no complaint', 'no complaint', 'no complaint', 'complaint', 'complaint', 'no complaint']
dataset['train'][label_column][:10]=['no complaint', 'no complaint', 'complaint', 'complaint', 'no complaint', 'no complaint', 'no complaint', 'complaint', 'complaint', 'no complaint']
```

#### Example of PEFT model inference using 🤗 Accelerate's Big Model Inferencing capabilities

An example is provided in [`~examples/causal_language_modeling/peft_lora_clm_accelerate_big_model_inference.ipynb`](https://github.com/huggingface/peft/blob/main/examples/causal_language_modeling/peft_lora_clm_accelerate_big_model_inference.ipynb).

## Conclusion

Parameter-Efficient Fine-Tuning (PEFT) stands as a transformative approach in the realm of working with Large Language Models (LLMs), addressing the critical challenges of computational demand and resource constraints. By focusing on adapting smaller segments of these expansive models, PEFT offers a path to harness the power of LLMs in a more accessible and sustainable manner. This approach not only broadens the scope of who can utilize these models but also expands the potential applications in various fields.

The integration of PEFT techniques, particularly those developed and made accessible by platforms like Hugging Face, marks a significant advancement in the field of natural language processing and artificial intelligence. These techniques allow for the efficient customization of LLMs for specific tasks, providing a balance between performance and resource utilization. The diverse range of PEFT methods, including LoRA, Prefix Tuning, and AdaLoRA, each offers unique advantages, catering to different requirements and scenarios.

Furthermore, the compatibility of PEFT with tools like 🤗 Accelerate and DeepSpeed illustrates its practicality and adaptability in real-world applications. This compatibility ensures that PEFT can be easily integrated into existing workflows, allowing for seamless scaling and adaptation of models.

The potential of PEFT extends beyond just language models; its principles are being applied to other areas such as diffusion models, indicating a broad spectrum of impact. Whether it's fine-tuning for specific tasks, adapting models for resource-limited settings, or pushing the boundaries of what's possible with consumer-grade hardware, PEFT is at the forefront of this evolution.

In conclusion, PEFT represents a significant step forward in the democratization of AI and ML technologies. It opens up new avenues for innovation, allowing a wider range of researchers, developers, and organizations to leverage the capabilities of large-scale models in a more efficient and effective manner. As the field continues to evolve, the role of PEFT in shaping the future of machine learning and AI will undoubtedly be pivotal, driving forward the possibilities of what can be achieved with these powerful tools.
