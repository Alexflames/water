class MyConditioner < Conditioner

end


class MyHeater < Heater 
  # Сеттер для температуры в такт (Пункт В)
  def set_heat heat
    @heat_per_tact = heat
  end

  # Геттер для температуры в такт
  def heat_per_tact
    @heat_per_tact
  end
end


class MyClimateControl < ClimateControl
  # Следующие 2 функции отвественны за
  # Проверка, требуется ли увеличение силы обогревателя в связи с 
  # понижением температуры. В положительном случае устанавливаем новую температуру
  # по описанной формуле, в противном случае возвращает текущую степень обогрева
  # новая степень обогрева не может быть меньше прежней, и от 0.5 до 4 (Пункт В)

  # Определение степени обогрева
  def calculate_grade home_temp
    calculate_grade = 0.5 + (@heater_start - home_temp) / 2 / 2.0 # Формула
    if calculate_grade > 4 then 4 else calculate_grade end  
  end

  # Увеличение степени обогрева если нужно
  def rise_to grade
    home_temp = @home.temperature.to_i                      # Округление
    calc_grade = calculate_grade home_temp
    if calc_grade > grade then calc_grade else grade end
  end

  # Переопределение функции 
  def check_heater
    if @home.temperature > @heater_start # если превышен темп. барьер
      heater = @home.heater
      heater.set_heat 0.5          # установить степень обогрева
                                         # на начальное значение (Пункт В)
      heater.set_off               # перевести в режим ожидания
    else
      heater = @home.heater
      heater.set_heat(rise_to(heater.heat_per_tact))  # Установить новую
                                                      # Степень обогрева
      heater.set_on                                   # перевести в режим работы
    end
  end
end


class MyReporter < Reporter   # Пункт Г
  def heater_status_s
    heater = @home.heater
    status = heater.status
    if !status
      "heater: " + bool_to_on_off_s(status)
    else
      "heater: " + bool_to_on_off_s(status) + 
        "heat: " + heater.heat_per_tact.to_s
    end
  end
end


class MyWeather < Weather
  def new_cyclon           # Чтобы экземляр был моего класса
    MyCyclon.new_cyclon self # запустить метод класса Cyclon для создания циклона,
                           # self передается как параметр 
  end

  def cyclons_review       # (Пункт Б)
    if @cyclons.size < 3   # если количество активных циклонов меньше 3-х
      @cyclons.push(new_cyclon.get_runner) if rand(10) > 6
                           # то с вероятностью 3/10 возникает 
                           # (добавляется) новый циклон (его процесс)
    end
  end
end

class MyCyclon < Cyclon
  MyCyclons = 
    Cyclons.push([-2.1, -1.4, -0.7,
                  0, 0.7, 1.4, 2.1]).push([-3.9, -2.6, -1.3, 0, 1.3, 2.6, 3.9])
     

  def self.new_cyclon weather
    # берется случайный представитель списка MyCyclons 
    # и с ним создается новый циклон (Пункт А)
    MyCyclon.new(MyCyclons.sample, weather)
  end
end

class MyGlasshouse < Glasshouse
  def set_weather             # Чтобы создавался экземляр моего класса
    @weather = MyWeather.new  # создание нового симулятора погоды
  end

  def set_glasshouse          # Чтобы создавался экземляр моего класса
    @conditioner = Conditioner.new self   # прикрепить новый кондиционер
    @heater = MyHeater.new self           # прикрепить новый обогреватель
    @heater.set_heat 0.5
    @climate_control = MyClimateControl.new(self, 15, 25)
                                          # прикрепить систему климат-контроля
    @reporter = MyReporter.new self       # прикрепить метеостацию
  end
end

