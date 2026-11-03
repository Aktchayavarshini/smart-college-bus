package com.collegebus.oop.exception;

/**
 * Custom runtime exception thrown when encapsulated data fails business domain invariants
 * (e.g. invalid phone number format, negative seat capacity, empty registration plates).
 */
public class InvalidDataException extends IllegalArgumentException {

    private final String fieldName;

    public InvalidDataException(String fieldName, String message) {
        super(String.format("Validation failed for field '%s': %s", fieldName, message));
        this.fieldName = fieldName;
    }

    public String getFieldName() {
        return fieldName;
    }
}
