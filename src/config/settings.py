# from typing import List, Dict
# from pydantic_settings import BaseSettings, SettingsConfigDict
# from pydantic import BaseModel


# class CorsSettings(BaseModel):
#     allow_origins: List[str]
#     allow_credentials: bool
#     allow_methods: List[str]
#     allow_headers: List[str]


# class TusSettings(BaseModel):
#     tmp_files_path: str
#     max_size: int
#     days_to_keep: int


# class LocalDispatcherSettings(BaseModel):
#     base_path: str


# class ScpDispatcherSettings(BaseModel):
#     host: str
#     port: int
#     username: str
#     password: str
#     base_path: str


# class DispatchersSettings(BaseModel):
#     active: str
#     local: LocalDispatcherSettings
#     scp: ScpDispatcherSettings


# class MongodbSettings(BaseModel):
#     collection_names: Dict[str, str]
#     database_name: str
#     connection_str: str


# class DatabaseSettings(BaseModel):
#     active: str
#     mongodb: MongodbSettings


# class ServerSettings(BaseModel):
#     port: int
#     log_level: str
#     workers: int
#     limit_concurrency: int
#     cors: CorsSettings


# class Settings(BaseSettings):
#     model_config = SettingsConfigDict(env_file=".env", env_nested_delimiter="__")

#     version: str
#     tus: TusSettings
#     server: ServerSettings
#     dispatchers: DispatchersSettings
#     database: DatabaseSettings


# def get_config():
#     return Settings()  # type: ignore


# if __name__ == "__main__":
#     settings = get_config()
#     print(settings.model_dump())
