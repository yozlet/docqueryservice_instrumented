import os
from typing import Dict, Optional, Type, Union
from pydantic import BaseModel, Field
from langchain.chat_models.base import BaseChatModel
from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic

from ..models import LLMModel

class ModelSettings(BaseModel):
    """Base model for LLM settings"""
    temperature: float = Field(default=0)
    model_name: str
    
    model_config = {
        'protected_namespaces': ()
    }

class OpenAISettings(ModelSettings):
    """Settings specific to OpenAI models"""
    openai_api_key: str
    base_url: str = Field(default="https://api.openai.com/v1")

class AnthropicSettings(ModelSettings):
    """Settings specific to Anthropic models"""
    anthropic_api_key: str

class ModelConfig(BaseModel):
    """Configuration for a specific LLM model"""
    model_class: Type[BaseChatModel]
    requires_key: str
    settings: Union[OpenAISettings, AnthropicSettings]
    
    model_config = {
        'protected_namespaces': ()
    }

class LLMConfig:
    """
    Configuration manager for different LLM models
    """
    def __init__(self):
        self.openai_api_key = os.getenv("OPENAI_API_KEY")
        self.anthropic_api_key = os.getenv("ANTHROPIC_API_KEY")
        
        if not self.openai_api_key and not self.anthropic_api_key:
            raise ValueError("Either OPENAI_API_KEY or ANTHROPIC_API_KEY must be provided")
        
        # Model configurations with their respective settings
        self.model_configs: Dict[LLMModel, ModelConfig] = {
            LLMModel.GPT35_TURBO: ModelConfig(
                model_class=ChatOpenAI,
                requires_key="OPENAI_API_KEY",
                settings=OpenAISettings(
                    temperature=0,
                    model_name="gpt-3.5-turbo-16k",
                    openai_api_key=self.openai_api_key,
                    base_url="https://api.openai.com/v1"
                )
            ),
            LLMModel.GPT4_TURBO: ModelConfig(
                model_class=ChatOpenAI,
                requires_key="OPENAI_API_KEY",
                settings=OpenAISettings(
                    temperature=0,
                    model_name="gpt-4-turbo-preview",
                    openai_api_key=self.openai_api_key,
                    base_url="https://api.openai.com/v1"
                )
            ),
            LLMModel.CLAUDE_3_SONNET: ModelConfig(
                model_class=ChatAnthropic,
                requires_key="ANTHROPIC_API_KEY",
                settings=AnthropicSettings(
                    temperature=0,
                    model_name="claude-3-sonnet-20240229",
                    anthropic_api_key=self.anthropic_api_key
                )
            ),
            LLMModel.CLAUDE_3_OPUS: ModelConfig(
                model_class=ChatAnthropic,
                requires_key="ANTHROPIC_API_KEY",
                settings=AnthropicSettings(
                    temperature=0,
                    model_name="claude-3-opus-20240229",
                    anthropic_api_key=self.anthropic_api_key
                )
            )
        }
    
    def get_llm(self, model: LLMModel) -> BaseChatModel:
        """
        Get an instance of the specified LLM model
        
        Args:
            model: The LLM model to instantiate
            
        Returns:
            An instance of the specified LLM model
            
        Raises:
            ValueError: If the required API key is not available
        """
        config = self.model_configs.get(model)
        if not config:
            raise ValueError(f"Unsupported model: {model}")
        
        # Check if required API key is available
        required_key = config.requires_key
        if required_key == "OPENAI_API_KEY" and not self.openai_api_key:
            raise ValueError(f"OpenAI API key required for model {model}")
        elif required_key == "ANTHROPIC_API_KEY" and not self.anthropic_api_key:
            raise ValueError(f"Anthropic API key required for model {model}")
        
        # Create and return the LLM instance
        return config.model_class(**config.settings.model_dump())
