class DiaryEntriesController < ApplicationController
    def index
        @diary_entries = DiaryEntry.all
        render json: @diary_entries
    end

    def show
        @diary_entry = DiaryEntry.find_by(id: params[:id])
        render json: @diary_entry
    end

    def create
        diary_entry = DiaryEntry.new(diary_entry_params)
        diary_entry.entry_date = Date.current
        
        if diary_entry.save
            render json: { diary_entry: DiaryEntrySerializer.new(diary_entry) }, status: :created
        else
            render json: { error: diary_entry.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        diary_entry = DiaryEntry.find_by(id: params[:id])
        diary_entry.destroy()
    end

    private
    def diary_entry_params
        params.require(:diary_entry).permit(:title, :content, :user_id)
    end
end
