magick mogrify -format png .\docs\images\GeneratorParams\*.ppm
magick mogrify -format png .\docs\images\EffectParams\*.ppm
del /q .\docs\images\GeneratorParams\*.ppm
del /q .\docs\images\EffectParams\*.ppm
