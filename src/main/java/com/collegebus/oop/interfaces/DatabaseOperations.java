package com.collegebus.oop.interfaces;

import com.collegebus.oop.exception.DatabaseOperationException;

import java.util.List;
import java.util.Optional;

/**
 * Generic Database CRUD Operations Interface.
 * Demonstrates Abstraction, Generic Programming, and DBMS integration contract.
 *
 * @param <T>  The domain entity type
 * @param <ID> The primary key identifier type
 */
public interface DatabaseOperations<T, ID> {

    /**
     * Create (Insert) a new record into the database table.
     * @param entity the domain object to persist
     * @return the persisted entity with generated primary key
     * @throws DatabaseOperationException if SQL execution fails
     */
    T create(T entity) throws DatabaseOperationException;

    /**
     * Read (Select) a single record matching the unique primary key.
     * @param id the primary key identifier
     * @return Optional containing the mapped entity, or empty if not found
     * @throws DatabaseOperationException if SQL execution fails
     */
    Optional<T> findById(ID id) throws DatabaseOperationException;

    /**
     * Read (Select) all records from the relational table.
     * @return List of all mapped entities
     * @throws DatabaseOperationException if SQL execution fails
     */
    List<T> findAll() throws DatabaseOperationException;

    /**
     * Update an existing record in the table.
     * @param entity the updated entity holding modified state
     * @return true if row was successfully updated, false otherwise
     * @throws DatabaseOperationException if SQL execution fails
     */
    boolean update(T entity) throws DatabaseOperationException;

    /**
     * Delete a record from the database table by its primary key.
     * @param id the primary key to delete
     * @return true if deletion was successful
     * @throws DatabaseOperationException if SQL execution fails
     */
    boolean deleteById(ID id) throws DatabaseOperationException;

    /**
     * Returns the total count of rows in the table.
     * @return row count
     * @throws DatabaseOperationException if SQL execution fails
     */
    long count() throws DatabaseOperationException;
}
