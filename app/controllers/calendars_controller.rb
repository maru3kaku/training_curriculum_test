class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ 
  def index
    get_Week 
    @plan = Plan.new
  end
  # 予定の保存
  def create    
    plan.create(plan_params)
    redirect_to action: :index
  end

  private
  def plan_params
    params.require(:plan).permit(:date , :plan)
  end
  def get_Week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    @week_days = []
    plans = plan.where(date: @todays_date..@todays_date + 6)
    7.times do |x|
      today_plans = []

      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      wday_num = @todays_date.wday# wdayメソッドを用いて取得した数値

      if wday_num >= 7   #「wday_numが7以上の場合」という条件式
         wday_num = wday_num -7
      end

      days = {month: (@todays_date + x).month,date: (@todays_date + x).day,plans: today_plans, wday: wdays[wday_num]}

      @week_days.push(days)
      puts x + 1
      
    end
  end
end
