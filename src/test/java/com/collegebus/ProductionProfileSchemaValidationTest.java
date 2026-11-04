package com.collegebus;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

/**
 * Boots the real production profile against the MySQL schema provisioned by CI.
 * This catches Hibernate/MySQL schema drift that the H2 unit-test profile cannot detect.
 */
@SpringBootTest
@ActiveProfiles("prod")
class ProductionProfileSchemaValidationTest {
    @Test
    void productionContextValidatesAgainstProvisionedMysqlSchema() {
        // Successful context startup proves datasource connectivity and ddl-auto=validate.
    }
}
