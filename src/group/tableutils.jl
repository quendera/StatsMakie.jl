struct GroupIdxsIterator{T <: AbstractVector}
    vec::T
    perm::Vector{Int}
end

GroupIdxsIterator(vec::AbstractVector) = GroupIdxsIterator(vec, sortperm(vec))

Base.IteratorSize(::Type{<:GroupIdxsIterator}) = Base.SizeUnknown()

function Base.iterate(n::GroupIdxsIterator, i = 1)
    vec, perm = n.vec, n.perm
    l = length(perm)
    i > l && return nothing
    row = vec[perm[i]]
    i1 = i
    while i1 <= l && isequal(row, vec[perm[i1]])
        i1 += 1
    end
    return (row => perm[i:(i1-1)], i1)
end
