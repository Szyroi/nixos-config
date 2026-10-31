from my_project.main import greet


def test_greet() -> None:
    assert greet("World") == "Hello, World!"
