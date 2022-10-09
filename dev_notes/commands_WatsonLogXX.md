## Идея

Команда `watson log -d` выводит лог следующего вида
```
	73dbe2a  09:15 to 11:19   2h 04m 12s  Gitea  [Work]
	16ad7a8  12:31 to 14:12   1h 41m 14s  Gitea  [Work, DevTools]
```

Задача: приводить все подобные текстовые блоки к более подходящему для ежедневных отчётов виду.

Предполагаемое использование:
`: WatsonLog` -- во всём файле все строки.
`: WatsonLog 5` -- отдельную строку с номером 5.
`: WatsonLog 2 4 6` -- отдельную строку с номерами 2, 4, 6.
`: WatsonLog 2 4,6` -- отдельную строку с номером 2 и строки с 4-ой по 6-ю включительно.


### WatsonLogShort

Написать команду для vim `WatsonLogShort`, которая будет приводить вставленные в заметку логи к виду:
```
* 09:15-11:19 (2h 04m 12s) [Work]
* 12:31-14:12 (1h 41m 14s) [Work, DevTools]
```


### WatsonLogRemarks

Написать команду для vim `WatsonLogRemarks`, которая будет приводить вставленные в заметку логи к заготовке вида:
```
* 09:15-11:19 (2h 04m 12s) [Work]

  Сделано:
  - ...
  
* 12:31-14:12 (1h 41m 14s) [Work, DevTools]

  Сделано:
  - ...
  
```


### WatsonLogRemarks

Написать команду для vim `WatsonLogRemarks`, которая будет приводить вставленные в заметку логи к заготовке вида:
```
* 09:15-11:19 (2h 04m 12s) [Work]

  Сделано:
  - ...
  -------------------------------   << Длина подгоняется под каждый заголовок лога

  Коммиты ...

* 12:31-14:12 (1h 41m 14s) [Work, DevTools]

  Сделано:
  - ...
  -----------------------------------------

  Коммиты ...

* 18:26-20:18 (1h 52m 17s) [Work, DevTools, EduTH]

  Сделано:
  - ...
  ------------------------------------------------

  Коммиты ...

```