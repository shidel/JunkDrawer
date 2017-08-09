; Jerome Shidel, 2017 Public Domain

; This generates no code as is.
; Only warning messages to demonstrate it is working


%imacro repeater_storage 1
    %xdefine %1 repeater_transient
    %warning %1 repeater_transient
%endmacro

%imacro onlyonce 2-*
    %xdefine repeater_name %1
    %xdefine repeater_name_count repeater_name %+ _count
    %xdefine repeater_transient %0 - 1
    repeater_storage repeater_name_count
    %assign  repeater_index 0
    %rotate 1
    %rep %0 - 1
        %ifidni %1, ax
            ; ignore
        %else
            %xdefine repeater_remember repeater_name %+ _ %+ repeater_index
            %xdefine repeater_transient %1
            repeater_storage repeater_remember
        %endif
        %assign  repeater_index repeater_index + 1
        %rotate 1
    %endrep
    %undef repeater_name
    %undef repeater_name_count
%endmacro

%imacro repeater 1
    %xdefine repeater_name %1
    %xdefine repeater_count repeater_name %+ _count
    %assign  repeater_index 0
    %rep repeater_count
        %xdefine repeater_value repeater_name %+ _ %+ repeater_index
        %warning repeater_name at index repeater_index is repeater_value
        ; do something here
        %assign repeater_index repeater_index + 1
    %endrep
    %undef repeater_name
    %undef repeater_count
%endmacro

onlyonce    Argh, ax, bx, cx, dx
; basically, it this auto-creates defines like doing:
; %define Argh_count 5 -1
; %define Argh_0 ax
; %define Argh_1 bx
; %define Argh_2 cx
; %define Argh_3 dx

repeater    Argh
; it iterrates through the 'Argh' defines group and outputs warnings of messages

onlyonce    Woah, a, b
repeater    Woah
repeater    Woah
