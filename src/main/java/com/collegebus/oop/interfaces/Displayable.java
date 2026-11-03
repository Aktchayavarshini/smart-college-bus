package com.collegebus.oop.interfaces;

/**
 * Interface representing any domain object capable of rendering a formatted summary card.
 * Used for dynamic method dispatch in the presentation and console layers.
 */
public interface Displayable {

    /**
     * Renders a human-readable summary card for UI or console demonstration.
     * @return formatted string representation
     */
    String getSummaryDetails();
}
