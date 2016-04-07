import org.junit.Test;
import static org.junit.Assert.*;
import java.util.*;

/*
 * %{class_name}Test
 */

public class %{class_name}Test {
    @Test public void testConstructor() {
        %{class_name} instance = new %{class_name}(6,9);
        assertEquals("constructor sets length as first argument", 6, instance.getLength());
        assertEquals("constructor sets width as second argument", 9, instance.getWidth());
    }
    @Test public void testArea() {
        %{class_name} instance = new %{class_name}(6,9);
        assertEquals("getArea() returns the product of length and width", 54, instance.getArea());
    }
    @Test public void testToEnglish() {
        %{class_name} instance = new %{class_name}(6,9);
        assertEquals("toEnglish() describes dimensions", "The room is 6 by 9", instance.getArea());
    }
    @Test public void testGetShape() {
        String shape = %{class_name}.getShape(3);
        assertEquals(".getShape() returns correct shape", "triangle",  %{class_name}.getShape(3));
        assertEquals(".getShape() returns correct shape", "pentagon",  %{class_name}.getShape(5));
    }
}
