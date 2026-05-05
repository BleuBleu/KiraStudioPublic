copy ..\..\KiraStudioPrivate\KiraStudio\Resources\Images\Generator*.tga .\docs\images\GeneratorIcons
copy ..\..\KiraStudioPrivate\KiraStudio\Resources\Images\Effect*.tga .\docs\images\EffectIcons
del /q .\docs\images\GeneratorIcons\*@2x.tga 
del /q .\docs\images\GeneratorIcons\*@4x.tga
del /q .\docs\images\EffectIcons\*@2x.tga 
del /q .\docs\images\EffectIcons\*@4x.tga
magick mogrify -format png .\docs\images\GeneratorIcons\*.tga
magick mogrify -format png .\docs\images\EffectIcons\*.tga
del /q .\docs\images\GeneratorIcons\*.tga
del /q .\docs\images\EffectIcons\*.tga
