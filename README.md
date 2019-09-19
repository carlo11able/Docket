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
The control on this interface belongs to the Admins.

### How-To Install and Run

Before installing all the gems, it is highly recommended to create a new gemset
if you are using Ruby Versioning Systems such as _rvm_ or _rbenv_. 
If you are using a POSIX operating system with conventional installations of
postgresql and rvm, you can simply descend into the Rails project directory and
execute the script `setup.sh`, with no arguments. 
The script will create a new gemset for the project with rvm, install all the
required gems and setup the database for you. Also, your password may be required
to _sudo_ into the _postgres_ user.

If you are using another OS, there's a brief list of things to do:

* Possibly create a new, isolated gemset for the project
* Create a new postgresql role (i.e. user) named _docket_
* Create two empty databases, named *docket_development* and *docket_test*
* Optionally, create another empty database called *docket_production*

Remember that you must select the _docket_ gemset each time you change shell
environment or terminal window.

Once the databases are created, you may need to `rails db:migrate`, also for
the testing environment.

Finally, you can launch the server executing either `rails server` or `rackup`

## Roles

The roles given to the users inside the platform are the following

### Labeler

The _Labeler_ the crowdsourcer itself, as it answers to the proposed questions. 
From the crowdsourcing presepective, it executes the batch.
A _Labeler_ can sign in also trough Facebook

### Customer

The _Customer_ of the platform load pictures with questions relative to them,
in order to have the data assets about the Labelers' answers.
From the crowdsourcing presepective, it gives the batch to the crowd.

### Admin

_Administrators_ monitor the overall platform functioning, as well as the
congruity of pictures and questions. They shall also report anomalies or bugs to
the developers.If necessary he can delete user's account, and he can tracks the labelers
who don't respond to questions in the correct way.
He also can upload photo using a REST service, called LoremFlickr, Admin should only
insert the key word on the form and LoremFlickr returns the url of this image.
The Admin upload photos with the willingness to track the bad labelers, who answers wrong, 
infact Admin can choose which is the corrrect answer about a question


## Data Models

Below are defined the data models used by Docket.

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
questions | has\_many | Questions related to a picture

### Question

Attribute | Type | Notes
:-:|:-:|---
answers | has\_many |
pictures | belongs\_to | Picture for which the question is valid

### Answer

Attribute | Type | Notes
:-:|:-:|---
value | boolean | If false then it is the first answer, else the second one
question | belongs\_to |
labeler | belongs\_to |



## User stories


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

#### About signup and login

* [ ] As an **unregistered user** I want to **signup** with email so that I can become a _Labeler_ or _Customer_
* [ ] As a _Labeler_ I want to **login** with my email so that I can see **labeler home page**



Link To Google Docs: https://docs.google.com/document/d/1IUMADjBWM-SG9SWTiomd8WQZ9r-28Ew_hYnUhwtfJGA/edit?fbclid=IwAR0ot6AAEcpNgmAx4FZsWGEbQrZjuPGIGNcWKKfy5k4gfGVKc4NF53JLk70#
