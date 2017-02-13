for i in 1..7
  Sale.create(
    buyer: "Comprador#{i}",
    description: "Compra#{i}",
    amount_centavos: i*500,
    quantity: i,
    address: "Endereço#{i}",
    provider: "Fornecedor#{i}"
  )
end
