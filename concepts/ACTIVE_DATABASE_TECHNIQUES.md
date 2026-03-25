# Active Databases

## My understanding
Active databases provide additional functionality for specifying **active rules**.

These rules can be triggered by  events that occur, and can initiate actions that have been specified if certain conditions are met.

Many commercial databases include some of the functionality provided by active databases in the form of [triggers](../sessions/session-2026-03-24.md).

Triggers are part of the SQL-99 and later standards.

### Generalized model
The model used to specify active database rules is referred to as the **event-condition-action (ECA)** model and has three components:

- **Event(s)** that triggers the rule.
    - Are database update opterations that are explicitly applied to the database.
    - Although in the general model, they could also be *temporal events* (or other kinds of external events).

- **Condition** that determines whether the action should be executed.

- **Action** to be taken.
    - Usually a sequence of SQL statements.
    - Can also be a database stransaction or an external program that will be automatically executed.

Triggers are can also be evaluated separately as:

- **Row-level trigger**
    
- Where the rule is triggered separately *for each tuple*.

- **Statement-level trigger**
    - Where the rule is triggered once for each triggering statement.

These are defined by the [`FOR EACH ROW` Clause](./FOR_EACH_ROW.md)

### Design and Implementation Issues for Active Databases

> Elmasri and Navathe (2016) also pose additional issues concerning how rules are designed and implemented.

\* Yet the following are not part of any SQL standard.

Events from the active database rules:
- In the [triggers notes](../sessions/session-2026-03-24.md), it is stated that there can be *before triggers* and *after triggers*.

- But there is also the concept of an **instead of trigger** that executes the trigger instead of executing the event.

Actions from the active database rules:
- This is a repetition from the [generalized model](#generalized-model), but the action, besides of being a database transaction, should also be able to be an external program that will be automatically executed.

Rule management:
- Any active database system should also allow users to **activate**, **deactivate**, and **drop** rules (by referring to their rule names).

- Another option is to group rules into named **rule sets**, so the whole set of rules can be activated, deactivated, or dropped.

- It is also useful to have a command that can trigger a rule (or rule set) via an explicit **PROCESS RULES** command issued by the user.

Separate transactions:
- Whether an action being executed should be considered as a *separate* transaction or be part of the same transaction that triggered the rule.

- Most commercial systems are limited to one or two of the following options:

    \* Let us assume that the triggering event occurs as part of a transaction execution. We shoul dfirst consider the options for how the triggering event is related to the evaluation of the rule's condition.

    1. **Rule condition evaluation** (also known as **rule consideration**).

    - The action is to be executed only after considereing whether the condition evaluates to true or false. There are three main possibilities for rule consideration.

        1. **Immediate consideration**
        - Where the  condition is evaluated as part of the same transaction as the triggering event and is evaluated *immediately*.
        - This case can be further categorized into three options:
            - Evaluate the condition *before* executing the triggering event.
            - Evaluate the condition after executing the triggering event.
            - Evaluate the condition *instead of* executing the triggering event.
        
        2. **Deferred consideration**
        - Where the condition is evaluated at the end of the transaction that included the triggering event.
        - In this case, there coud be many triggered rules waiting to have their conditions evaluated.

        3. **Detached consideration**
        - Where the condition is evaluated as a separate transaction, spawned from the triggering transaction.

    2. Relationship between evaluating the rule condition and *executing* the rule action.

    - There are (again) three execution options:
        1. Immediate
        2. Deferred
        3. Detached

    - Most active systems use the first one.
        - As soon as the condition is evaluated, if it returns `true`, the action is *immediately* executed.

    - The Oracle system uses the *immediate consideration* model, but allows the user to specify for each rule whether the *before* or *after* option is used with the immediate condition evaluation.

    - The STARBUST system uses the *deferred consideration* option, so that all rules triggered by a transaction wait until the triggereing transaction reaches its end.
        - And issues its `COMMIT WORK` command before the rule conditions are evaluated.
    
    3. Distinction between *row-level rules* and *statement-level* rules.

    - The SQL-99 standard and the Oracle system allow the user to choose.
    
    - STARBUST uses statement-level semantics only.

    - More information on this can be accessed through the [FOR EACH ROW Clause page](./FOR_EACH_ROW.md).

### Difficulties that may have limited widespread use of active rules
- There are no easy-to-use techniques for designing, writing, and verifying rules.
    - It is difficult to verify that a set of rules is **consistent**
        - 2+ rules in the set do not contradict one another.
    - It is also difficult to guarantee **termination** of a set of rules under all circumstances.
        - One rule can trigger another rule, which can trigger the first rule, creating an infinite loop.
    
- Elmasri and Navathe (2016) suggest that if active rules are to reach their potential, it is necessary to develop tools for the design, debugging, and monitoring of active rules that can help users design and debug their rules.



## Why it matters
As the use of database systems has grown, users have demanded additional functionality from these software packages.

Increased functionality would make it easier to implement more advanced and complex user applications.

## Example
[This example is taken from the Intro to DB Systems book, and can be accessed through the Resources section.](#resources)

```sql
CREATE TRIGGER Total_sal1
    AFTER INSERT ON EMPLOYEE
    FOR EACH ROW
    WHEN ( NEW.Dno IS NOT NULL )
    UPDATE DEPARTMENT
    SET Total_sal = Total_sal + NEW.Salary
    WHERE Dno = NEW.Dno;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)
