import org.junit.Test;
import static org.junit.Assert.*;

/*
 * %{class_name}Test
 */

public class %{class_name}Test {
    @Test public void testSome%{class_name}Method() {
        %{class_name} instance = new %{class_name}();
        assertTrue("some%{class_name}Method() should return 'true'", instance.some%{class_name}Method());
    }
}
