class Api::V1::JournalPromptsController < ApplicationController
  before_action :authorized

  def index
    journal_prompts = JournalPrompt.all
    render json: journal_prompts, each_serializer: JournalPromptSerializer
  end

  def show
    journal_prompt = JournalPrompt.find(params[:id])
    render json: journal_prompt, serializer: JournalPromptSerializer
  end

  def create
    journal_prompt = JournalPrompt.new(journal_prompt_params)
    if journal_prompt.save
      render json: journal_prompt, serializer: JournalPromptSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: journal_prompt.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    journal_prompt = JournalPrompt.find(params[:id])
    if journal_prompt.update(journal_prompt_params)
      render json: journal_prompt, serializer: JournalPromptSerializer
    else
      render json: { error: 'validation_failed', message: journal_prompt.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    journal_prompt = JournalPrompt.find(params[:id])
    journal_prompt.destroy
    head :no_content
  end

  private

  def journal_prompt_params
    params.require(:journal_prompt).permit(:question, :category, :description)
  end
end
