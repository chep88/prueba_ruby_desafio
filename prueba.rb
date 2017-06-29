
def menu
  puts '=============='
  puts '--Bienvenido--'
  puts '=============='
  puts '1) Genera Promedio'
  puts '2) Inasistencias'
  puts '3) Aprobados'
  puts '4) Salir'
  puts '=============='
end

def obtiene_promedio(file)
  a = {}
  file.each_index do |i|
    alumno = file[i].split(',')
    alumno_int = alumno.reject { |x| x == 'A' }
    # se restamenos uno descontar el identificador del aluno
    a[alumno[0].to_s] = (alumno_int.inject(0) { |suma, nota| suma + nota.to_i })/ (alumno.count - 1)
  end
  a
end

def obtiene_inasistencia(file)
  a = {}
  file.each_index do |i|
    alumno = file[i].split(',')
    alumno_fal = alumno.select { |x| x == 'A' }
    a[alumno[0]] = alumno_fal.count 
  end
  a
end

def es_aprobado(nota_de_aprobacion, hash)
  puts hash.select { |key, value| value.to_i >=  nota_de_aprobacion }
end

def ejecuta_menu(menu, book)
  case menu
    when 1
      genera_Archivo(obtiene_promedio(book))
      puts 'Archivo Generado...Presiona enter para continuar...'
      gets.chomp
    when 2
      #puts obtiene_inasistencia(book)
      puts obtiene_inasistencia(book)
      puts 'Presiona enter para continuar...'
      gets.chomp
    when 3
      nota_apruba = 5
      a = obtiene_promedio(book)
      es_aprobado(nota_apruba.to_i , a)
      puts 'Presiona enter para continuar...'
      gets.chomp
    else
      puts 'Favor ingresa una opcion que se te muestra en el menu, Presiona enter para continuar...'
      gets.chomp
  end
end

def leer_archivo
  line = []
  File.open('data.csv', 'r') { |file| line = file.readlines }
  line
end

def genera_Archivo(contenido)
  File.open('promedio.txt', 'w') { |file| file.puts contenido}
end

file = leer_archivo
loop do
  system('clear')
  menu
  opcion_menu = gets.chomp.to_i

  break if opcion_menu == 4
  system('clear')
  ejecuta_menu(opcion_menu, file)
end
