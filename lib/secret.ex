defmodule Math.Secret do
  import Math.Polynomial

  def encoder(min_shares, participant_count, secret) do
    if(participant_count < min_shares) do
      throw("participant_count must be greater than or equal to min_shares")
    end

    seed_points =
      Enum.to_list(1..(min_shares - 1)) |> Enum.map(fn x -> {x, Enum.random(1000..9999)} end)

    f_x = interpolate([{0, secret} | seed_points])

    # return points for participants
    Enum.to_list(1..participant_count) |> Enum.map(fn x -> {x, f_x.(x)} end)
  end

  def decoder(shares) do
    g_x = interpolate(shares)

    # return secret
    g_x.(0)
  end
end
