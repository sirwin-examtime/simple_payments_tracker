payments_tracker
================

Introduction
------------
This project implements a basic Payments Tracker as a mountable Rails engine.

Requirements
------------
+ Rails 3.2

Terminology
-----------
Some of the terms used in this Gem:

 1. 'Payment Items' are the basic units of organization of items that require payment tracking e.g. a school outing

 1. 'Payment Installments' are the basic units of recording the details of an individuel payment against a Payment Item.

 1. 'Payer Payments' are the interface for users to make Payment Installments against a Payment Item.

    e.g. a Payer makes an installment against a Payment Item <i>through</i> a Payer Payment object
    
    For a Payment Item with an amount of £10.00, a Payer may make 2 installments each of £5 through the same Payer Payment record to fulfil their part of the Payment Item.


 1. 'Admin users' are privileged users.

    Your application may enforce various types of admin roles, some with higher privileges than others.  You will need to enforce your own responsibilities around which users are allowed to create and manage Payment Items

Usage
-----
Create a Payment Item and assign a group of users ('payers') to it. This creates a Payer Payment instance for each payer. Admin users then use the Payer Payment instance to make installments on behalf of the payers towards the related Payment Item.


This gem supports the following types of Payment Items:

 1. General Payment Items

   For example: a trip has been arranged for a group of users.  Set the amount value (per user).  The payment item will automatically close when each user in the group has paid the full amount through 1 or more installments.

 2.  Multiple Payment Items

    For example: recurring purchases of school uniforms

 3.  Open Payment Items

    For example: fundraising
