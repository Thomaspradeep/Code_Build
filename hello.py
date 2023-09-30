# Bug 1: Unused variable
unused_variable = 42

def main():
    print("Hello, world!")

# Bug 2: Division by zero
def divide_by_zero():
    result = 10 / 0  # This will cause a ZeroDivisionError

if __name__ == "__main__":
    main()
    divide_by_zero()
