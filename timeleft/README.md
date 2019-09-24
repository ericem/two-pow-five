# Time Left (timeleft)

## What is it?

We are blessed with a finite number of days on this planet and we should try and maximize every day we have left. But just how many days exactly do we have left? This utility will query your life expectancy from data collected by the National Center for Health Statistics and tell you how much time you have left. 

[1] https://data.cdc.gov/resource/w9j2-ggv5.json
[2] https://data.cdc.gov/NCHS/NCHS-Death-rates-and-life-expectancy-at-birth/w9j2-ggv5
[3] https://dev.socrata.com/foundry/data.cdc.gov/w9j2-ggv5

## Install Build Requirements

Install the compiler:

```
brew install crystal
```

## Compiling

To build a debug version:

```
make
```

To build a release version:

```
make release
```

To install the binary:
```
make install
```


## Usage

Calculate your time left, by entering your birthday:
```
timeleft <year> <month> <day>
```

For example if your birthday was also on the Unix epoch:
```
timeleft 1970 01 01
```

Expected output:
```
You will live to be 78.9 years old
Your death day is Tuesday November 24 2048
You have 28817 days left
```

### Query Parameters

By default timeleft will query for the average life expectancy of all races and all genders combined. You can change the query by setting some environment variables:

```
RACE=<race> SEX=<sex> timeleft <year> <month> <day>
```

Check the API [3] for valid values.

### Cache Refresh

Timeleft will cache the results of the query, to the following location:

```
$HOME/.cache/mortality.json
```

If you want to run timeleft with a different birthday, or you want to refresh the cache, use the REFRESH environment variable:

```
REFRESH=true timeleft 1970 01 01
```
