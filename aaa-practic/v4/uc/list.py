from interface.i_td import ITd
from ett.todo import Todo

class TdList:
    def __init__(self, repo: ITd):
        self.repo = repo

    def execute(self) -> list[Todo]:
        return self.repo.list_all()