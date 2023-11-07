# LLM Fine-tuning

In the realm of **machine learning**, the concept of fine-tuning is akin to the art of **adaptation** and **specialization**. Just as a master craftsperson tailors their skills to the nuances of a new material, a machine learning model undergoes fine-tuning to adapt to the specific patterns and intricacies of a new dataset. This fine-tuning process is especially crucial when the new dataset—while related—is substantially different from the data the model was originally trained on, known as **out-of-distribution data**.

To illustrate this, imagine a highly efficient **spam detection system** trained extensively on email data. It has become adept at recognizing the common patterns and signals of spam in emails. Now, suppose we want to deploy this system on social media platforms to detect spam messages in posts or comments. The nature of text and spam signals in social media can be vastly different from those in emails due to the use of slang, shorter texts, different formatting, and a variety of multimedia content. Direct application of the email-trained model to social media is likely to result in a high error rate due to the **distributional shift**.

Instead of retraining a new model from the ground up with social media data, which is resource-intensive and time-consuming, **fine-tuning** the existing model on a curated dataset from social media can be much more efficient. The model's prior knowledge gleaned from emails serves as a foundational layer of understanding text content, which can then be refined and adjusted to capture the nuances of social media spam.

- **Fine-tuning** is critical for adapting models to **new datasets** where the distribution differs from the original training data.
- It involves **updating model parameters** to better fit the new data, much like a craftsperson adapts their skills to a new material.
- **Efficiency** is gained by building on the existing knowledge base of the model, rather than starting anew.
- This approach is akin to teaching a spam detection system, originally trained on emails, to understand and detect spam on **social media platforms**.

## What is fine-tuning?

```{image} figs/fine-tuning.png
:width: 60%
:align: center
```

Imagine a scenario where a **machine learning model** is like a seasoned chef, trained at a culinary school in Paris, who specializes in classic French cuisine. This chef has spent years perfecting the art of delicate sauces, pastry, and confections, developing an instinctive feel for French ingredients and techniques. Their skill set is highly specialized, and they excel within the familiar environment of a French kitchen.

Now, consider that this chef is suddenly tasked with preparing authentic Thai cuisine. The foundational culinary skills are there, but the ingredients, flavor profiles, and cooking techniques of Thai food are quite distinct from French cuisine. If the chef tries to prepare Thai dishes with only their French culinary training, the results might be subpar. The chef’s palate is fine-tuned to butter and herbs, not lemongrass and fish sauce.

**Fine-tuning** in this context would involve the chef learning to adapt their existing skills to the new cuisine. They wouldn't need to start from scratch—many of their kitchen skills are transferable—but they would need to learn the nuances that make Thai food unique. By training under a Thai master chef or practicing with a smaller, focused set of recipes, the chef can begin to recalibrate their culinary intuition to embrace the flavors and techniques of Thai cooking.

Applying this back to machine learning, fine-tuning a pre-trained model—like our French chef—on a new dataset is analogous to teaching the chef to master Thai cuisine. The model's basic structure and learned parameters serve as a strong starting point, and with additional training on a smaller, specialized dataset, it can adapt to perform well on a different task, like detecting trucks on highways rather than passenger cars in urban settings.

- **Pre-training** is like a chef learning to cook French cuisine—developing a broad base of skills.
- Moving to **Thai cuisine** represents a shift in data distribution—a new task with new patterns.
- **Fine-tuning** is the chef adapting their skills to Thai cooking, just as a model is updated for a new dataset.
- The **core skills** (or model parameters) are adapted, not replaced, making the process efficient.
- The result is a model—or chef—that can perform the new task effectively with less additional training than starting from scratch.

## Different LLM Fine-Tuning Techniques

```{image} figs/fine-tuning-techniques.png
:width: 60%
:align: center
```

When it comes to fine-tuning **Large Language Models (LLMs)**, the approach must be tailored to the specific end-use. Fine-tuning is not a one-size-fits-all solution; it ranges from minor architectural adjustments to significant retraining of the model.

For instance, if we possess a pre-trained LLM designed for text generation, but we wish to pivot its functionality to **sentiment or topic classification**, a **repurposing** of the model is required. This involves a slight modification to the model's architecture, particularly the way its embeddings are utilized. **Embeddings**—numerical vectors representing input features—are key to this process. Some LLMs, such as those in the GPT family, use these embeddings to generate subsequent tokens in text generation tasks. In repurposing for classification, these embeddings are instead routed to a **classification model**—usually a series of fully connected layers that translate the embedding vectors into class probabilities.

During this **repurposing phase**, the **attention layers** of the LLM, which are responsible for understanding the context within the text, are often **frozen**. This means they are not updated during the fine-tuning process, resulting in significant **savings in computational cost**. However, the classifier built on top of the embeddings must be trained using a **supervised dataset**, which comprises text examples and their corresponding classes. The size and quality of this dataset are crucial and must be commensurate with the complexity of the classification task and the capabilities of the classifier.

Alternatively, there are scenarios where a more thorough fine-tuning is necessary, involving the updating of the **transformer model's parameters**. This **full fine-tuning** requires the attention layers to be **unfrozen**, allowing for comprehensive retraining. Such a process is inherently more **resource-intensive** and complex, especially as the size of the model scales up. To mitigate this, practitioners can opt to keep certain parts of the model frozen or employ advanced techniques to reduce the computational overhead.

- **Repurposing** involves minor architectural changes, particularly for tasks like sentiment or topic classification.
- **Embeddings** are re-routed to a new classifier model, while the transformer's attention layers are typically **frozen**.
- **Computational efficiency** is gained by not updating the entire model, just the classifier using a **supervised dataset**.
- **Full fine-tuning** may be necessary for more complex tasks, requiring **unfreezing** and updating the entire model's parameters, which is more **computationally expensive**.
