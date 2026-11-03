package com.collegebus.oop.exception;

/**
 * Custom checked exception wrapping low-level java.sql.SQLException.
 * Demonstrates exception chaining and abstraction over raw database drivers.
 */
public class DatabaseOperationException extends BusTransportationException {

    private final String sqlQuery;

    public DatabaseOperationException(String message, Throwable cause) {
        super("DBMS_QUERY_ERROR", message, cause);
        this.sqlQuery = "N/A";
    }

    public DatabaseOperationException(String message, String sqlQuery, Throwable cause) {
        super("DBMS_QUERY_ERROR", message, cause);
        this.sqlQuery = sqlQuery;
    }

    public String getSqlQuery() {
        return sqlQuery;
    }
}
