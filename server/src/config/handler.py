import os
# Class responsible for setting and getting system environment variables.
class Config:    
    @classmethod
    def set_value(cls, key, value):
        os.environ[key] = value
    @classmethod
    def get_value(cls, key):
        return os.getenv(key)

