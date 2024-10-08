import asyncio


async def main(n) -> None:  # 1
    i = 1
    p = 1
    d = 1
    if (n >= 1): print(p)
    if (n >= 2): print(d)
    if (n>2):
      while i <= n:
        result = p+d
        print(result)
        p=d
        d=result
        i = i + 1

        await asyncio.sleep(1)


if __name__ == "__main__":
    asyncio.run(main(5))