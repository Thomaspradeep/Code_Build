public class BugExample {

    // Bug 1: Unused variable
    int unusedVariable = 42;

    public static void main(String[] args) {
        // Bug 2: Dead code
        if (false) {
            System.out.println("This code is never executed.");
        }

        // Bug 3: Null pointer exception
        String text = null;
        int length = text.length(); // This will throw a NullPointerException

        // Bug 4: Infinite loop
        while (true) {
            // This loop will never exit
        }
    }
}
