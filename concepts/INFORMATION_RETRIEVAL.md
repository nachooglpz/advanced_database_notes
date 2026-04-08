# Information Retrieval (IR)

## My understanding
- Gerald Salton describes this as **"the discipline that deals with the structure, analysis, organization, storage, searching, and retrieval of information"** (1968, as cited in Elmasri and Navathe, 2016).
- Elmasri and Navathe even enhance this definition to add that it applies to satisfy a user's information needs (2016).

- This term actually preceeds the database field and was originally a part of Library and Information Science programs, mainly concerned with the **retrieval of cataloged information in libraries based on titles, authors, topics, and keywords.**

- IR systems, therefore, go beyond database systems and do not limit the user to:
    - A specific query language
    - Know the structure (schema) or content of a particual database.

- IR systems use a user's information need expressed as a free-form search request (keyword search query, or simply query) for interpretation by the system.

- There are two types of retrieval models:
    - Satistical retrieval models:
        - Boolean
        - [Vector Space](./VECTOR_SPACE_MODEL.md)
        - Probabilistic
    - Semantic Model

### Databases vs IR Systems
- Databases deal with structured information retrieval through well-defined formal languages.
    - These formal languages are for representation and manupulation based on the theoretically founded data models.
    - Efficient algorithms have been developed for operators that allow rapid execution of complex queries.
    - They use the relational model employing SQL for queries and transactions.
    - The queries are mapped into relational algebra operations (and search algorithms) and return a new relation.

- IR, deals with unstructured search with possibly vague query or search semantics.
    - And without a well defined logical schematic representation.
    - It views data (or documents) according to some scheme (e.g. the [vector space model](./VECTOR_SPACE_MODEL.md)).
    - There is no fixed language for defining the structure (schema) of the document (or for operating said document).
    - Queries tend to be a set of query terms (keywords) or a free-form natural language phrase.
    - An IR query result is a list of document IDs, or some pieces of text/multimedia objects, or a list of links to webpages.
    - Complex statistical analysis is (sometimes) performed to determine the relevance of each document or parts of a document to the user request.

- While a database system maintains a large amount of metadata and allows their use in query optimization, the operations in OR systems rely on the data values themselves and their occurrence frequencies.

## Why it matters
Traditionally, databases have dealt and managed *structured data*. But in order to deal with unstructured data, or unstructured information (infomration that does not have a well-defined fomral model and correspoinding formal language for representation and reasoning, but rather is based on understanding of natural language).

## Example
Structured data can have the following form:
```
HOUSES (Lot #, Address, Square footage, Listed price)
```

An example for unstructured data can be found in the World Wide Web, where the information might be stored in messages and documents that contain textural and multimedia information.

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)