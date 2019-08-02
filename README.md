# Docket

## Overview

Docket is a crowdsourced portal which offers a simple solution to label big
amounts of pictures. Such classification is essential for Machine Learning
professionals, as it is able to supply the required data assets for Supervised
Machine Learning.

The **batch** delegated to the crowd consists in answering to binary questions
on the images loaded by the platform customers.

#### Providing high-quality answers

To verify the crowdsourcers' quality, Docket uses _LoremFlickr_ - an external
image hosting service - to select, by keywords, randomly choosen pictures, and
proposing questions (of which the answer is obvious and already known).
A labeler which gives the wrong answer will be reported to Docket administrators,
that will check their activity and assert the congruous behaviour.


## Roles

The roles given to the users inside the platform are the following

### Labeler

The _Labeler_ the crowdsourcer itself, as it answers to the proposed questions. 
From the crowdsourcing presepective, it executes the batch.

### Customer

The _Customer_ of the platform load pictures with questions relative to them,
in order to have the data assets about the Labelers' answers.
From the crowdsourcing presepective, it gives the batch to the crowd.

### Admin

_Administrators_ monitor the overall platform functioning, as well as the
congruity of pictures and questions. They shall also report anomalies or bugs to
the developers.


## Data Models

Below are defined the data models used by Docket.

Inheritance will be almost surely implemented via Single Table Inheritance (here is
[a stunning StackOverflow post](https://stackoverflow.com/questions/23374216/inheritance-of-rails-models)
on that)

**TODO**: Define a proper relationship between _Picture_ and _Question_, which
shall be easily represented through Rails models. 
The "problem" is that, to keep a many-to-many relationship between them, we
should use something like `has_many <xxx> through: <yyy>` or
`has_many_and_belongs_to`, which creates a new relation table (see
[Rails Association Basics](https://edgeguides.rubyonrails.org/association_basics.html)).
The thing is: is it worth to keep such relation and not to consider it as a
many-to-one relationship? The matter is not about the ability to do that, but
the implications in database schema simplicity and maintainability. 
Also, referring to the guide that I've linked, integrity checks on that relationship
might not be so trivial to implement.  
\-jcondor

### User

Attribute | Type | Notes
:-:|:-:|---
name | string |
email | string |
password | string | Not stored in the db
password\_confirmation | Not stored in the db

### Labeler

**Inherits**: User

Attribute | Type | Notes
:-:|:-:|---
questions | has\_many | Answer to a known question (batch)

### Customer

**Inherits**: User

Attribute | Type | Notes
:-:|:-:|---
pictures | has\_many |
questions | has\_many |

### Admin

**Inherits**: User

### Picture

Attribute | Type | Notes
:-:|:-:|---
url | string | Can be either local (self-hosted) or remote (i.e. hosted elsewhere)

**TODO**: Question relationship

### Question

Attribute | Type | Notes
:-:|:-:|---
answers | has\_many |

**TODO**: Picture relationship

### Answer

Attribute | Type | Notes
:-:|:-:|---
value | boolean | If false then it is the first answer, else the second one
question | belongs\_to |
labeler | belongs\_to |

**NOTE**: I turned 'value' (which in the UML schema was `Domanda.domanda` from
an _integer of domain {1,2}_ to a _boolean_ (which, if you think about that, is
an integer of domain {0,1})


## User stories

#### About signup and login

* [ ] As an **unregistered user** I want to **signup** with email so that I can become a _Labeler_ or _Customer_
* [ ] As a _Labeler_ I want to **login** with my email so that I can see **labeler home page**
* [ ] As a _Labeler_ I want to **login** with **facebook** so that I can see **labeler home page**

#### About Labelers

* [ ] As a _Labeler_ I want to have **labeler profile** to change my email
* [ ] As a _Labeler_ I want to have **labeler profile** to change my name
* [ ] As a _Labeler_ I want to have **labeler profile** to change my surname
* [ ] As a _Labeler_ I want to have **labeler profile** to change my password
* [ ] As a _Labeler_ I want to have **labeler home page** so that I can see all **answers** given by me so that I can **modify** them
* [ ] As a _Labeler_ I want to have **labeler home page** so that I can see **random question page**
* [ ] As a _Labeler_ I want to have **random question page** so that I can answer it 

#### About Customers

* [ ] As a _Customer_ I want to have **customer home page** so that I can see **new batch page**
* [ ] As a _Customer_ I want to have **new batch page** so that I can **upload** a local photo
* [ ] As a _Customer_ I want to have **new batch page** so that I can add new question
* [ ] As a _Customer_ I want to have **new batch page** so that I can **create** **new batch**
* [ ] As a _Customer_ I want to have **customer home page** so that I can see **edit batch page**
* [ ] As a _Customer_ I want to have **edit batch page** so that I can **delete question**  
* [ ] As a _Customer_ I want to have **edit batch page** so that I can **add new question** 
* [ ] As a _Customer_ I want to have **edit batch page** so that I can **update batch**
* [ ] As a _Customer_ I want to have **customer home page** so that I can see **batch view answer**

#### About Admins

* [ ] As an _Admin_ I want to have **admin home page** so that I can see the **customer's list**
* [ ] As an _Admin_ I want to see the **customers list** so that I can see  a **customer profile**
* [ ] As an _Admin_ I want to have **admin home page** so that I can see the **labeler's list**
* [ ] As an _Admin_ I want to see the **labelers list** so that I can see a **labeler profile**
* [ ] As an _Admin_ I want to have **admin customer profile** page so that I can **delete customer profile**
* [ ] As an _Admin_ I want to have **admin labeler profile page**  so that I can **delete labeler's profile**
* [ ] As an _Admin_ I want to have **admin labeler profile page** so that I can **delete labeler's answer**
* [ ] As an _Admin_ I want to see **batch page** so that I can **delete question**
* [ ] As an _Admin_ I want to see **batch page** so that I can see **batch answer page**
* [ ] As an _Admin_ I want to have **batch answer page** so that I can **delete labeler's answer**
* [ ] As an _Admin_ I want to see **batch page** so that I can see the **customer**'s profile who upload the **batch**
* [ ] As an _Admin_ I want to see **batch page** so that I can **delete batch**

