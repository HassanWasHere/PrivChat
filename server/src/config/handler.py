import os

class Config:    
    @classmethod
    def set_value(cls, key, value):
        os.environ[key] = value
    @classmethod
    def get_value(cls, key):
        return os.getenv(key)


Config.get_value("a")
