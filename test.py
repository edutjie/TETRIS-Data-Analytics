a = ['buku', 'balpoin', 'kertas', 'penggaris', 'penghapus', 'tipp-ex']

print(max(a[2:4] + ['meja']))
print(a[:])
print(a[-5:-3])
print(a[4::-2])
print(a[-6])

b = {
    'a': 1,
    2: 'b',
}

print(b['a'])
print(b[2])
print(int("0xA5", 16))
print('Hari Jum\'at')


a_dict = {'color': 'blue', 'fruit': 'apple', 'pet': 'dog'}
d_items = a_dict.items()
print(d_items)

# func = lambda x: return x
# print(func(2))

print((lambda x: (x + 3) * 5 / 2)(3))
print(100 / 25)