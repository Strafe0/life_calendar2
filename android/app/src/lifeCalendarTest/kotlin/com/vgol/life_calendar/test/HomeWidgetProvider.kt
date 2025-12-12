package com.vgol.life_calendar.test

// Импортируем ваш основной провайдер и даем ему псевдоним BaseProvider
import com.vgol.life_calendar.HomeWidgetProvider as BaseProvider

// Создаем пустой класс-наследник. 
// Теперь для системы это виджет в пакете .test, но с логикой из основного пакета.
class HomeWidgetProvider : BaseProvider()